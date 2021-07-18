function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 1;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
theta=4.0;

xd=sin(t);
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
e=x1-xd;
ut=x(1);
dx1=ut+theta*x1^2;
de=dx1-dxd;

c1=10;xite=1.0;

s=c1*e+ut+theta*x1^2-dxd;
v=-e-c1*de-2*theta*x1*dx1+ddxd-xite*sign(s);

sys(1)=v;
function sys=mdlOutputs(t,x,u)

M=2;
if M==1
    theta=4.0;
    xd=sin(t);dxd=cos(t);
    x1=u(2);
    e=x1-xd;
    xite=0.30;
    ut=-xite*sign(e)-theta*x1^2+dxd;
elseif M==2
    ut=x(1);
end
sys(1)=ut;