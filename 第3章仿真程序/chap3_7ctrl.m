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
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
a=25;b=133;
am=20;bm=100;
D=10;
c=10;
ym=u(1);y=u(3);
dym=u(2);dy=u(4);

e=y-ym;
de=dy-dym;
s=c*e+de;

r=sin(pi*t);
xite=0.02;

wt=1/b*(-c*abs(de)-abs(bm*r)-D-xite-abs(am*dym)-abs(a*dy));

M=2;
if M==1
   ut=wt*sign(s);
elseif M==2
   delta=0.02;
   if s>delta
	   sats=1;
	elseif abs(s)<=delta
		sats=s/delta;
	elseif s<-delta
		sats=-1;
	end
   ut=wt*sats;
end   
sys(1)=ut;