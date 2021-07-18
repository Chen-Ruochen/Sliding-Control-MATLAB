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
sizes.NumOutputs     = 5;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0.01;0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
u=u(1);
mc=0.5;mp=0.5;
l=0.3;
I=1/3*mp*l^2;
g=9.8;
fai1=(mc+mp)*(I+mp*l^2)/(mp*l);
fai2=(mc+mp)*g;
fai3=mp*l;

gx1=fai1*sec(x(1))-fai3*cos(x(1));

dt=sin(t);
sys(1)=x(2);
sys(2)=1/gx1*(u-dt+fai2*tan(x(1))-fai3*x(2)^2*sin(x(1)));
function sys=mdlOutputs(t,x,u)
mc=0.5;mp=0.5;
l=0.3;
I=1/3*mp*l^2;
g=9.8;

fai1=(mc+mp)*(I+mp*l^2)/(mp*l);
fai2=(mc+mp)*g;
fai3=mp*l;

sys(1)=x(1);
sys(2)=x(2);
sys(3)=fai1;
sys(4)=fai2;
sys(5)=fai3;