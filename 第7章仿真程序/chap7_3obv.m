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
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0 0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
x1=u(1);
e1=x1-x(1);
alfa1=1;alfa2=1;
epc=0.01;
h1=alfa1/epc;
h2=alfa2/(epc^2);

A=[-h1 1;-h2 0];
eig(A);

sys(1)=x(2)+h1*e1;
sys(2)=-10*x(2)-x(1)+u(2)+h2*e1;
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);