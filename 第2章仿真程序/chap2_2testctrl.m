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
sizes.NumOutputs     = 4;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
thd=u(1);    
dthd=cos(t);
ddthd=-sin(t);

th=u(2);
dth=u(3);

c=15;
e=thd-th;
de=dthd-dth;
s=c*e+de;

fx=25*dth;
b=133;
epc=5;

S=1;
if S==1
    k=0;
elseif S==2
    k=10;
elseif S==3
    k=20;
elseif S==4
    k=30;
end    
ut=1/b*(epc*sign(s)+k*s+c*de+ddthd+fx);

sys(1)=ut;
sys(2)=e;
sys(3)=de;
sys(4)=k;