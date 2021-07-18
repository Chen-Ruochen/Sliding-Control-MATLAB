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
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [0.1*ones(3,1)];
str = [];
ts  = [];
function sys=mdlDerivatives(t,x,u)
xd=0.1*sin(t);
dxd=0.1*cos(t);
ddxd=-0.1*sin(t);

e=u(1);
de=u(2);
x1=xd+e;
x2=dxd+de;

k1=30;
s=k1*e+de;

for i=1:1:3
    thtah(i,1)=x(i);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fsd=0;
gs=5*(s+3);
uh(1)=1/(1+exp(gs));

uh(2)=exp(-s^2);

gs=5*(s-3);
uh(3)=1/(1+exp(gs));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fsu=uh;
for i=1:1:3
   fsd=fsd+uh(i);
end
fs=fsu/(fsd+0.001);

gama=150;
S=gama*s*fs;
for j=1:1:3
    sys(j)=S(j);
end

function sys=mdlOutputs(t,x,u)
xd=0.1*sin(t);
dxd=0.1*cos(t);
ddxd=-0.1*sin(t);

e=u(1);
de=u(2);
x1=xd+e;
x2=dxd+de;

k1=30;
s=k1*e+de;

for i=1:1:3
    thtah(i,1)=x(i);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fsd=0;
gs=5*(s+3);
uh(1)=1/(1+exp(gs));

uh(2)=exp(-s^2);

gs=5*(s-3);
uh(3)=1/(1+exp(gs));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fsu=uh;
for i=1:1:3
   fsd=fsd+uh(i);
end
fs=fsu/(fsd+0.001);
h=thtah'*fs';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=9.8;mc=1.0;m=0.1;l=0.5;
S=l*(4/3-m*(cos(x1))^2/(mc+m));
fx=g*sin(x1)-m*l*x2^2*cos(x1)*sin(x1)/(mc+m);
fx=fx/S;
gx=cos(x1)/(mc+m);
gx=gx/S;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ut=1/gx*(-fx+ddxd-1*h-k1*de);
   
xite=10+0.01;
sys(1)=ut;
sys(2)=xite*sign(s);
sys(3)=h;