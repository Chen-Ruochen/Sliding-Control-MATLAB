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
global xite cij bj h c
sizes = simsizes;
sizes.NumContStates  = 10;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = 0.1*ones(10,1);
str = [];
ts  = [];
cij=[-1 -0.5 0 0.5 1;
    -1 -0.5 0 0.5 1];
bj=5;
h=[0,0,0,0,0];
c=5;
xite=0.01;
function sys=mdlDerivatives(t,x,u)
global xite cij bj h c
thd=u(1);
dthd=0.1*cos(t);
ddthd=-0.1*sin(t);

x1=u(2);
x2=u(3);
e=thd-x1;
de=dthd-x2;

s=c*e+de;

xi=[x1;x2];
for j=1:1:5
    h(j)=exp(-norm(xi-cij(:,j))^2/(2*bj^2));
end

for i=1:1:5
    wf(i,1)=x(i);
end
for i=1:1:5
    wg(i,1)=x(i+5);
end
fxn=wf'*h';
gxn=wg'*h'+0.01;

ut=1/gxn*(-fxn+ddthd+xite*sign(s)+c*de);

gama1=10;gama2=1.0;
S1=-gama1*s*h;
S2=-gama2*s*h*ut;
for i=1:1:5
    sys(i)=S1(i);
end
for j=6:1:10
    sys(j)=S2(j-5);
end

function sys=mdlOutputs(t,x,u)   
global xite cij bj h c
thd=u(1);
dthd=0.1*cos(t);
ddthd=-0.1*sin(t);

x1=u(2);
x2=u(3);
e=thd-x1;
de=dthd-x2;

s=c*e+de;

for i=1:1:5
    wf(i,1)=x(i);
end
for i=1:1:5
    wg(i,1)=x(i+5);
end

xi=[x1;x2];
for j=1:1:5
    h(j)=exp(-norm(xi-cij(:,j))^2/(2*bj^2));
end

fxn=wf'*h';
gxn=wg'*h'+0.01;

ut=1/gxn*(-fxn+ddthd+xite*sign(s)+c*de);
   
sys(1)=ut;
sys(2)=fxn;
sys(3)=gxn;