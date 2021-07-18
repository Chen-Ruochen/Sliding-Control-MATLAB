function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 6;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)

x1=u(4);
x2=u(5);
x3=u(6);

x=[x1 x2 x3]';
xr=[u(1) u(2) u(3)]';

S=2;
if S==1
    dxr=[0 0 0]';
elseif S==2
    dxr=[cos(t) -sin(t) cos(t)]';
end

z=x-xr;

A=[-2.548 9.1 0;
    1 -1 1;
    0 -14.2 0];
B=[1 0 0;
    0 1 0;
    0 0 1];

F=[-1.5075   -5.0500    0.0000;
   -5.0500   -0.5000    6.6000;
    0.0000    6.6000   -1.5000];

a1=1;a2=1.1;
fxr=0.5*[abs(xr(1)+a1)-abs(xr(1)-a2);0;0];
   
delta=0.05;
 	kk=1/delta;
 for i=1:1:3
 	if z(i)>delta
 		sats(i)=1;
 	elseif abs(z(i))<=delta
 		sats(i)=kk*z(i);
 	elseif z(i)<-delta
 		sats(i)=-1;
    end
 end
xite=[50;50;50];

ur=-F*xr-inv(B)*A*xr+inv(B)*dxr;

%us=-inv(B)*[xite(1)*sign(z(1)) xite(2)*sign(z(2)) xite(3)*sats]';
us=-inv(B)*[xite(1)*sats(1) xite(2)*sats(2) xite(3)*sats(3)]';
%us=0;

ur=-F*xr-inv(B)*A*xr-inv(B)*fxr+inv(B)*dxr;
ut=F*x+ur+us;

sys(1:3)=ut;