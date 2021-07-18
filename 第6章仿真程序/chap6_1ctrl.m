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
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
zd=u(1);
dzd=0.1*pi*cos(pi*t);
ddzd=-0.1*pi*pi*sin(pi*t);

x1=u(2);
x2=u(3);
fx=u(4);
gx=u(5);
c1=35;c2=35;

z1=x1-zd;
alfa1=-c1*z1+dzd;
z2=x2-alfa1;
dz1=x2-dzd;
D=10;
xite=D+0.10;
%xite=0;
ut=(-fx-xite*sign(z2)-c1*dz1+ddzd-c2*z2-z1)/(gx+0.001);
sys(1)=ut;