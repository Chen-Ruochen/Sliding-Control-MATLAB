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
sizes.NumOutputs     = 1;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = 0*ones(1,5);
str = [];
ts  = [];
cij=1*[-1 -0.5 0 0.5 1];
bj=1.0;
function sys=mdlDerivatives(t,x,u)
global cij bj
s=u(1);
x2=u(3);

b=133;

xi=x2;
h=zeros(5,1);
for j=1:1:5
    h(j)=exp(-norm(xi-cij(:,j))^2/(2*bj^2));
end
gama=0.10;
for i=1:1:5
    sys(i)=-1/gama*s*b*h(i);
end
function sys=mdlOutputs(t,x,u)
global cij bj
s=u(1);
x2=u(3);

xi=x2;

W=[x(1) x(2) x(3) x(4) x(5)]';
h=zeros(5,1);
for j=1:1:5
    h(j)=exp(-norm(xi-cij(:,j))^2/(2*bj^2));
end
deltap=W'*h;

sys(1)=deltap;