function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 =[1,-1,-1];
str = [];
ts = [];
function sys=mdlDerivatives(t,x,u)
a1=1;a2=1.1;
fx=0.5*[abs(x(1)+a1)-abs(x(1)-a2);0;0];
A=[-2.548 9.1 0;
    1 -1 1;
    0 -14.2 0];
B=[1 0 0;
    0 1 0;
    0 0 1];
ut=[u(1) u(2) u(3)]';
dt=[50*sin(t) 50*sin(t) 50*sin(t)]';

dx=fx+A*x+B*ut+dt;

sys(1)=dx(1);
sys(2)=dx(2);
sys(3)=dx(3);
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);