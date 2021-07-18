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
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0 0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
ut=u(1);
x1=x(1);
x2=x(2);
a1=0.5*sin(x1)*(1+cos(x1))*x2^2-10*sin(x1)*(1+cos(x1));
a2=0.25*(2+cos(x1))^2;
alfax=a1/a2;

b=0.25*(2+cos(x1))^2;
betax=1/b;
d1=cos(3*t);
dt=0.1*d1*cos(x1);

sys(1)=x(2);
sys(2)=alfax+betax*ut+dt;
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);