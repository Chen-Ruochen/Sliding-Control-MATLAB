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
sizes.NumOutputs     = 1;
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
tol=u(1);
th=u(2);
d_th=u(3);
dd_th=u(5);

J=10;
thd=sin(t);
d_thd=cos(t);
dd_thd=-sin(t);
ddd_thd=-cos(t);
e=th-thd;
de=d_th-d_thd;
dde=dd_th-dd_thd;

n1=30;n2=30;
n=25;
s=dde+n1*de+n2*e;

xite=80;   %dot(d)+n*dmax,dmax=3
ut=-1/n*(-n*J*dd_th+J*(-ddd_thd+n1*dde+n2*de)+xite*sign(s));

sys(1)=ut;