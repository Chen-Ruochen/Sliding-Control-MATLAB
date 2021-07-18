function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
persistent a2

if t==0
   a2=readfis('fsmc.fis');
end
xd=sin(t);
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
x2=u(3);

e=xd-x1;
de=dxd-x2;

c=25;
s=c*e+de;

g=9.8;mc=1.0;m=0.1;l=0.5;
S=l*(4/3-m*(cos(x1))^2/(mc+m));
fx=g*sin(x1)-m*l*x2^2*cos(x1)*sin(x1)/(mc+m);
fx=fx/S;
gx=cos(x1)/(mc+m);
gx=gx/S;

ueq=1/gx*(c*de+ddxd-fx);
D=5;
xite=D+0.15;
us=1/gx*xite*sign(s);

M=2;
if M==1       % Using conventional equavalent sliding mode control
   Mu=1.0;
elseif M==2
	Mu=evalfis([s],a2);  % Using fuzzy equavalent sliding mode control
end
ut=ueq+Mu*us;

sys(1)=ut;
sys(2)=Mu;