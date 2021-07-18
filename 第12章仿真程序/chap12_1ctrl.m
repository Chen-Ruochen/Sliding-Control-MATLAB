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
persistent e0 de0 dde0
T=3.0;

xd=u(1);
dxd=cos(t);
ddxd=-sin(t);

x=u(2:3);
dx=u(4:5);
if t==0
   e0=x(1);
   de0=x(2)-1;
   dde0=dx(2);
end

c=15;

e=x(1)-xd;
de=x(2)-dxd;
dde=dx(2)-ddxd;

if t<=T
   A0=-10/T^3*e0-6/T^2*de0-1.5/T*dde0;
   A1=15/T^4*e0+8/T^3*de0+1.5/T^2*dde0;
   A2=-6/T^5*e0-3/T^4*de0-0.5/T^3*dde0;
   p=e0+de0*t+1/2*dde0*t^2+A0*t^3+A1*t^4+A2*t^5;
   dp=de0+dde0*t+A0*3*t^2+A1*4*t^3+A2*5*t^4;
   ddp=dde0+A0*3*2*t+A1*4*3*t^2+A2*5*4*t^3;
else
   p=0;dp=0;ddp=0;
end

s=(c*e+de)-(c*p+dp);


fx=-25*x(2);
D=3.0;
xite=D+0.10;

%ut=-1/133*(1/c*(de-dp)+fx-ddxd-ddp+xite*sign(s));

delta=0.02;
 	kk=1/delta;
  	if s>delta
 		sats=1;
 	elseif abs(s)<=delta
 		sats=kk*s;
 	elseif s<-delta
 		sats=-1;
    end
ut=-1/133*(1/c*(de-dp)+fx-ddxd-ddp+xite*sats);

sys(1)=ut;