function [sys,x0,str,ts] = spacemodel(t,x,u,flag)

switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 6;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [0.1*ones(6,1)];
str = [];
ts  = [];

function sys=mdlDerivatives(t,x,u)
thd=0.2*sin(pi*t+pi/2);
dthd=0.2*pi*cos(pi*t+pi/2);
ddthd=-0.2*pi*pi*sin(pi*t+pi/2);

th=u(2);
dth=u(3);

e=th-thd;
de=dth-dthd;

k1=10;
k2=25;
k=[k2;k1];

s=u(3)-u(1);
for i=1:1:5
    alfa(i,1)=x(i+1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fsd=0;
for l=1:1:5
   gs=-[(s+pi/6-(l-1)*pi/12)/(pi/24)]^2;
	miu(l)=exp(gs);
end

for l=1:1:5
	 fsu(l)=miu(l);
	 fsd=fsd+miu(l);
end

if fsd==0
   fsd=fsd+0.01;
end

fs=fsu/fsd;

ufz=alfa'*fs';

E=x(1);
uvs=-E*sign(s);

u=ufz+uvs;

xite1=200;
S1=-xite1*s*fs;

xite2=0.50;
sys(1)=xite2*abs(s);
for i=2:1:6
    sys(i)=S1(i-1);
end

function sys=mdlOutputs(t,x,u)
thd=0.2*sin(pi*t+pi/2);
dthd=0.2*pi*cos(pi*t+pi/2);
ddthd=-0.2*pi*pi*sin(pi*t+pi/2);

th=u(2);
dth=u(3);

e=th-thd;
de=dth-dthd;

k1=10;
k2=25;
k=[k2;k1];

s=u(3)-u(1);
for i=1:1:5
    alfa(i,1)=x(i+1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fsd=0;
for l=1:1:5
   gs=-[(s+pi/6-(l-1)*pi/12)/(pi/24)]^2;
	miu(l)=exp(gs);
end

for l=1:1:5
	 fsu(l)=miu(l);
	 fsd=fsd+miu(l);
end

if fsd==0
   fsd=fsd+0.01;
end

fs=fsu/fsd;

ufz=alfa'*fs';

E=x(1);
uvs=-E*sign(s);

ut=ufz+uvs;   %FSMC
%ut=-1500*e-150*de;  %PD

sys(1)=ut;
sys(2)=E;