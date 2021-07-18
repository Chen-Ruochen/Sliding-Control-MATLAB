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
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[-1 0];
function sys=mdlOutputs(t,x,u)
x1d=sin(t);
dx1d=cos(t);
ddx1d=-sin(t);

x1p=u(2);
x2p=u(3);

e1p=x1p-x1d;
e2p=x2p-dx1d;

c=50;
xite=30;
sp=c*e1p+e2p;
g=9.8;m=1;l=0.25;d=2.0;I=4/3*m*l^2;

ut=I*(d/I*x2p+m*g*l*cos(x1p)+ddx1d-c*e2p-xite*sp);

sys(1)=ut;