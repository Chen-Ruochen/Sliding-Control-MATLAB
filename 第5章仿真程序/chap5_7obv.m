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
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0 0];
str=[];
ts=[-1 0];
function sys=mdlDerivatives(t,x,u)
x1p=x(1);
x2p=x(2);

y=u(1);
ut=u(2);
yp=u(3);

k1=2;k2=1;
K=[k1 k2]';

g=9.8;m=1;l=0.25;d=2.0;
I=4/3*m*l^2;

X=1/I*(-d*x2p-m*g*l*cos(x1p))+1/I*ut;
 
sys(1)=x2p+k1*(y-yp);
sys(2)=X+k2*(y-yp);
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);