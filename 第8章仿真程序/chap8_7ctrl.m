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
sizes.NumContStates  = 53;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [0.1*ones(53,1)];
str = [];
ts  = [];

function sys=mdlDerivatives(t,x,u)
r1=50;r2=1;r3=10;

xd=0.1*sin(t);
dxd=0.1*cos(t);
ddxd=-0.1*sin(t);

x1=u(2);
x2=u(3);
e=x1-xd;
de=x2-dxd;

k1=3;
s=k1*e+de;

for i=1:1:25
    thtaf(i,1)=x(i);
end
for i=1:1:25
    thtag(i,1)=x(i+25);
end
for i=1:1:3
    thtah(i,1)=x(i+50);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fsd1=0;
fsd2=0;
for l1=1:1:5
   gs1=-[(x1+pi/6-(l1-1)*pi/12)/(pi/24)]^2;
	u1(l1)=exp(gs1);
end

for l2=1:1:5
   gs2=-[(x2+pi/6-(l2-1)*pi/12)/(pi/24)]^2;
	u2(l2)=exp(gs2);
end

for l1=1:1:5
	for l2=1:1:5
		fsu1(5*(l1-1)+l2)=u1(l1)*u2(l2);
		fsd1=fsd1+u1(l1)*u2(l2);
	end
end

fs1=fsu1/(fsd1+0.001);

fx1=thtaf'*fs1';
gx1=thtag'*fs1'+0.001;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gs3=5*(s+3);
u3(1)=1/(1+exp(gs3));

u3(2)=exp(-s^2);

gs3=5*(s-3);
u3(3)=1/(1+exp(gs3));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fsu2=u3;
for i=1:1:3
   fsd2=fsd2+u3(i);
end
fs2=fsu2/(fsd2+0.001);
h1=thtah'*fs2';

ut=1/gx1*(-fx1-k1*de+ddxd-h1);

S1=r1*s*fs1;
S2=r2*s*fs1*ut;
S3=r3*s*fs2;

for i=1:1:25
    sys(i)=S1(i);
end
for j=26:1:50
    sys(j)=S2(j-25);
end

for j=51:1:53
    sys(j)=S3(j-50);
end

function sys=mdlOutputs(t,x,u)
xd=0.1*sin(t);
dxd=0.1*cos(t);
ddxd=-0.1*sin(t);

x1=u(2);
x2=u(3);
e=x1-xd;
de=x2-dxd;

k1=3;
s=k1*e+de;

for i=1:1:25
    thtaf(i,1)=x(i);
end
for i=1:1:25
    thtag(i,1)=x(i+25);
end
for i=1:1:3
    thtah(i,1)=x(i+50);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fsd1=0;
fsd2=0;
for l1=1:1:5
   gs1=-[(x1+pi/6-(l1-1)*pi/12)/(pi/24)]^2;
	u1(l1)=exp(gs1);
end

for l2=1:1:5
   gs2=-[(x2+pi/6-(l2-1)*pi/12)/(pi/24)]^2;
	u2(l2)=exp(gs2);
end

for l1=1:1:5
	for l2=1:1:5
		fsu1(5*(l1-1)+l2)=u1(l1)*u2(l2);
		fsd1=fsd1+u1(l1)*u2(l2);
	end
end

fs1=fsu1/(fsd1+0.001);

fx1=thtaf'*fs1';
gx1=thtag'*fs1'+0.001;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gs3=5*(s+3);
u3(1)=1/(1+exp(gs3));

u3(2)=exp(-s^2);

gs3=5*(s-3);
u3(3)=1/(1+exp(gs3));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fsu2=u3;
for i=1:1:3
   fsd2=fsd2+u3(i);
end
fs2=fsu2/(fsd2+0.001);
h1=thtah'*fs2';

ut=1/gx1*(-fx1-k1*de+ddxd-h1);
   
sys(1)=ut;
sys(2)=fx1;
sys(3)=gx1;