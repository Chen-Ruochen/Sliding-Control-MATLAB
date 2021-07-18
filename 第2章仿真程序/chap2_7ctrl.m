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
sizes.NumOutputs     = 1;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
xd=u(1);
dxd=2*pi*cos(2*pi*t);
ddxd=-(2*pi)^2*sin(2*pi*t);
x=u(2);dx=u(3);
e=xd-x;
de=dxd-dx;

c=25;
s=c*e+de;

f=-25*dx;
b=133;

ueq=1/b*(c*de+ddxd-f);
D=50;
xite=0.10;
K=D+xite;
usw=1/b*K*sign(s);

ut=ueq+usw;

sys(1)=ut;