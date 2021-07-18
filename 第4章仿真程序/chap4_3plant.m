function [sys,x0,str,ts]=plant(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0 0 0 0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u) 
r1=1;r2=0.8;
m1=1;m2=1.5;

M11=(m1+m2)*r1^2+m2*r2^2+2*m2*r1*r2*cos(x(3));
M22=m2*r2^2;
M21=m2*r2^2+m2*r1*r2*cos(x(3));
M12=M21;
M=[M11 M12;M21 M22];

V12=m2*r1*sin(x(3));
V=[-V12*x(4) -V12*(x(2)+x(4));V12*x(1) 0];

g1=(m1+m2)*r1*cos(x(3))+m2*r2*cos(x(1)+x(3));
g2=m2*r2*cos(x(1)+x(3));
G=[g1;g2];

D=[10*x(2)+30*sign(x(2)) 10*x(4)+30*sign(x(4))]';

T=[u(1) u(2)]';
S=inv(M)*(T-V*[x(2);x(4)]-G-D);

sys(1)=x(2);
sys(2)=S(1);
sys(3)=x(4);
sys(4)=S(2);
function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);
sys(4)=x(4);