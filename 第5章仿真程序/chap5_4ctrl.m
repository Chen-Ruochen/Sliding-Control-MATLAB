function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {1,2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[-1 0];
function sys=mdlOutputs(t,x,u)
J=1/133;
b=25/133;

thd=u(1);
dthd=cos(t);
ddthd=-sin(t);

th=u(2);
dth=u(3);
dp=u(5);

e=thd-th;
de=dthd-dth;

c=10;
xite=5.0;
s=c*e+de;

%Saturated function 
delta=0.05;
kk=1/delta;
if abs(s)>delta
  	sats=sign(s);
else
	sats=kk*s;
end

k0=10;
%ut=J*(c*de+ddthd+b/J*dth-1/J*dp+k0*s+xite*sign(s));
ut=J*(c*de+ddthd+b/J*dth-1/J*dp+k0*s+xite*sats);

sys(1)=ut;