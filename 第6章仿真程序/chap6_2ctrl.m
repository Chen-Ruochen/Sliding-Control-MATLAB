function [sys,x0,str,ts] = controller(t,x,u,flag)

switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9},
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
c1=10;
k1=15;
h=20;
beta=1.5;
beta=0.2;
Fmax=3;

A=-25;
B=133;

xd=u(1);
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
x2=u(3);

z1=x1-xd;
dz1=x2-dxd;

z2=x2-dxd+c1*z1;

rou=k1*z1+z2;

ut=1/B*(-k1*(z2-c1*z1)-A*(z2+dxd-c1*z1)-Fmax*sign(rou)+ddxd-c1*dz1-h*(rou+beta*sign(rou)));

sys(1)=ut;