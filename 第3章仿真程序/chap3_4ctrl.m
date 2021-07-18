function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
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
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
xd=sin(t);
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
x2=u(3);
fx=u(4);
gx=u(5);

e=x1-xd;
de=x2-dxd;
c=30;
s=c*e+de;
D=15;


M=1;
if M==1
	xite=D+0.50;
	v=ddxd-c*de-xite*sign(s);
elseif M==2
   xite=D+0.50;
   delta0=0.03;
   delta1=5;
   delta=delta0+delta1*abs(e);
   v=ddxd-c*de-xite*s/(abs(s)+delta);
end

ut=(-fx+v)/(gx+0.002);
sys(1)=ut;