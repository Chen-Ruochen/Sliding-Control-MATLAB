function [sys,x0,str,ts] = obv(t,x,u,flag)
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
sizes.NumContStates  = 6;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0;0;0;0;0;0];
str = [];
ts  = [0 0];
function sys=mdlDerivatives(t,x,u)
w=[x(1) x(2) x(3)]';
v=[x(4) x(5) x(6)]';

x1=u(1);
ut=u(4);

T=18.5;K=0.20;
A=[0 1 0;
    0 0 1;
    -1/T^3 -3/T^2 -3/T];

k1=30-3/T;
k2=300-3*k1/T-3/T^2;
k3=1000-1/T^3-3/T^2*k1-3/T*k2;

k=[k1 k2 k3]';
c=[1 0 0];
A0=A-k*c;

e4=[0 0 1]';

dw=A0*w+k*x1;
dv=A0*v+e4*ut;

sys(1)=dw(1);
sys(2)=dw(2);
sys(3)=dw(3);
sys(4)=dv(1);
sys(5)=dv(2);
sys(6)=dv(3);
function sys=mdlOutputs(t,x,u)
T=18.5;K=0.20;
b=K/T^3;
w=[x(1) x(2) x(3)]';
v=[x(4) x(5) x(6)]';

xp=w+b*v;

sys(1)=xp(1);
sys(2)=xp(2);
sys(3)=xp(3);