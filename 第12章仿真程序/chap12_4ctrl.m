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
L=2;
xd=u(1);dxd=cos(t);ddxd=-sin(t);
x1=u(2);x2=u(3);
e=xd-x1;de=dxd-x2;

g=9.8;mc=1.0;m=0.1;l=0.5;
S=l*(4/3-m*(cos(x1))^2/(mc+m));
fx=g*sin(x1)-m*l*x2^2*cos(x1)*sin(x1)/(mc+m);
fx=fx/S;
gx=cos(x1)/(mc+m);
gx=gx/S;

alfa0=2;
beta0=1;
p0=9;q0=5;
p=3;q=1;
fai=100;

s0=e;
ds0=de;
z0=abs(s0)^(q0/p0)*sign(s0);
s1=ds0+alfa0*s0+beta0*z0;
z1=abs(s1)^(q/p)*sign(s1);

Ts=(alfa0*0.1^((p0-q0)/p0)+beta0)/beta0;
ts=p0/(alfa0*(p0-q0))*log(Ts);

xite=1.0;
T=fai*0.1^((p-q)/p)+xite;
t_s1=p/(fai*(p-q))*log(T)/xite;   %Time of s1=0

gama=L/abs(z1)+xite;

ut=1/gx*(ddxd-fx+alfa0*ds0+beta0*q0/p0*z0*ds0+fai*s1+gama*z1);

sys(1)=ut;