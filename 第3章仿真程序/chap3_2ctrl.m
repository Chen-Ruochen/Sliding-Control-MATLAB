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
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];

function sys=mdlOutputs(t,x,u)
thd=u(1);
dthd=cos(t);
ddthd=-sin(t);
th=u(2);
dth=u(3);

c=10;
e=th-thd;
de=dth-dthd;

dt=0.10*sin(2*pi*t);
D=0.10;

e0=pi/6;
de0=0-1.0;
s0=de0+c*e0;
ft=s0*exp(-130*t);
df=-130*s0*exp(-130*t);

s=de+c*e-ft;
R=ddthd+c*dthd;

J_min=0.80;
J_max=1.20;

aJ=(J_min+J_max)/2;
dJ=(J_max-J_min)/2;

M=2;
if M==1
    ut=-aJ*(c*dth-df)+aJ*R-[dJ*abs(c*dth-df)+D+dJ*abs(R)]*sign(s);
elseif M==2
    fai=0.05;
	if s/fai>1
	   sat=1;
	elseif abs(s/fai)<=1
	   sat=s/fai;
	elseif s/fai<-1
	   sat=-1;
	end
    ut=-aJ*(c*dth-df)+aJ*R-[dJ*abs(c*dth-df)+D+dJ*abs(R)]*sat;
end
sys(1)=ut;
sys(2)=s;