function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {1,2,4,9}
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
c1=5;
c2=5;

yd=u(1);
dyd=cos(t);
ddyd=-sin(t);
dddyd=-cos(t);

x1=u(2);
x2=u(3);
x3=u(4);

e=x1-yd;
de=x2-dyd;
dde=x3-ddyd;

s=c1*e+c2*de+dde;
v=-dddyd+c1*de+c2*dde;

T=18.5;K=0.2;
b=K/(T^3);
alfa=-1/(T^3)*x1-3/(T^2)*x2-3/T*x3;
xite=0.50;
ut=-1/b*(v+alfa+xite*s);

sys(1)=ut;