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
x0=[0.5,0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
d=0.10*sin(t);
B=10+3*sin(2*pi*t);
J=3+0.5*sin(2*pi*t);

sys(1)=x(2);
sys(2)=1/J*(u-B*x(2)-d);
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);