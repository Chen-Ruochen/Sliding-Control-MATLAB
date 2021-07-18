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
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
alfa0=2;beta0=1;
p0=9;q0=5;
fai=10;
gama=10;
p=3;q=1;

x(1)=u(1);
x(2)=u(2);

s0=x(1);
s1=x(2)+alfa0*s0+beta0*s0^(q0/p0);

%The time to reach the equilibrium x=0
x0=5;
T=(alfa0*x0^((p0-q0)/p0)+beta0)/beta0;
ts=p0/(alfa0*(p0-q0))*log(T);

z=sign(s1)*(abs(s1))^(q/p);
ut=1/(x(1)^2+1)*(-cos(x(1))-alfa0*x(2)-beta0*q0/p0*x(1)^((q0-p0)/p0)*x(2)-fai*s1-gama*z);

sys(1)=ut;