function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
x1d=sin(t);
dx1d=cos(t);
ddx1d=-sin(t);
x1=u(2);
x2=u(3);
deltap=u(5);

e=x1-x1d;
de=x2-dx1d;
c=5;
s=c*e+de;

D=1.0;
xite=D+0.50;
fai=0.02;
if abs(s)<=fai
   sat=s/fai;
else
   sat=sign(s);
end
b=133;
f=-25*x2;
ut=1/b*(-c*de-f+ddx1d-xite*sat)+deltap;
sys(1)=ut;
sys(2)=s;