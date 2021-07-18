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
global cij bj c
sizes = simsizes;
sizes.NumContStates  = 5;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = 0*ones(1,5);
str = [];
ts  = [];
cij=0.10*[-1 -0.5 0 0.5 1;
        -1 -0.5 0 0.5 1];
bj=5.0;
c=15;
function sys=mdlDerivatives(t,x,u)
global cij bj c
thd=0.1*sin(t);
dthd=0.1*cos(t);
x1=u(2);
x2=u(3);
e=thd-x1;
de=dthd-x2;

s=c*e+de;

xi=[e;de];
h=zeros(5,1);
for j=1:1:5
    h(j)=exp(-norm(xi-cij(:,j))^2/(2*bj^2));
end
gama=0.015;
W=[x(1) x(2) x(3) x(4) x(5)]';
for i=1:1:5
    sys(i)=-1/gama*s*h(i);
end
function sys=mdlOutputs(t,x,u)
global cij bj c
thd=0.1*sin(t);
dthd=0.1*cos(t);
ddthd=-0.1*sin(t);
x1=u(2);
x2=u(3);
e=thd-x1;
de=dthd-x2;
s=c*e+de;
W=[x(1) x(2) x(3) x(4) x(5)]';
xi=[e;de];
h=zeros(5,1);
for j=1:1:5
    h(j)=exp(-norm(xi-cij(:,j))^2/(2*bj^2));
end
fn=W'*h;

g=9.8;mc=1.0;m=0.1;l=0.5;
S=l*(4/3-m*(cos(x1))^2/(mc+m));
gx=cos(x1)/(mc+m);
gx=gx/S;

if t<=1.5
    xite=1.0;
else
    xite=0.10;
end
ut=1/gx*(-fn+ddthd+c*de+xite*sign(s));
sys(1)=ut;
sys(2)=fn;