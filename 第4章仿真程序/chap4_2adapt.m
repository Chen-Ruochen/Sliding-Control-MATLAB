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
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
x1=u(1);
x2=u(2);

thd=0.1*sin(t);
dthd=0.1*cos(t);
ddthd=-0.1*sin(t);

e=x1-thd;
de=x2-dthd;
c=30;
s=c*e+de;

gama1=50;gama2=50;gama3=50;

sys(1)=gama1*(0.5*s^2*x2*sec(x1)*tan(x1)+s*sec(x1)*(c*de-ddthd));
sys(2)=gama2*s*tan(x1);
sys(3)=gama3*(0.5*s^2*x2*sin(x1)-s*x2^2*sin(x1)-s*cos(x1)*(c*de-ddthd));
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);   %fai1
sys(2)=x(2);   %fai2
sys(3)=x(3);   %fai3