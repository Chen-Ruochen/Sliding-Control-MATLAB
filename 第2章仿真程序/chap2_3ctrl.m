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
sizes.NumOutputs     = 3;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
r=u(1);    
dr=cos(t);
ddr=-sin(t);

th=u(2);
dth=u(3);

c=15;
e=r-th;
de=dr-dth;
s=c*e+de;

fx=25*dth;
b=133;
dL=-10;dU=10;
d1=(dU-dL)/2;
d2=(dU+dL)/2;
dc=d2-d1*sign(s);

epc=0.5;k=10;
ut=1/b*(epc*sign(s)+k*s+c*de+ddr+fx-dc);

sys(1)=ut;
sys(2)=e;
sys(3)=de;