function [sys,x0,str,ts] = func(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {1,2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 6;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
qd1=u(1);qd2=u(2);
dqd1=cos(t);dqd2=cos(t);
dqd=[dqd1 dqd2]';
ddqd1=-sin(t);ddqd2=-sin(t);
ddqd=[ddqd1 ddqd2]';

q1=u(3);dq1=u(4);
q2=u(5);dq2=u(6);

e1=q1-qd1;
e2=q2-qd2;
e=[e1 e2]';
de1=dq1-dqd1;
de2=dq2-dqd2;
de=[de1 de2]';

r1=1;r2=0.8;
m1=1;m2=1.5;

M11=(m1+m2)*r1^2+m2*r2^2+2*m2*r1*r2*cos(q2);
M22=m2*r2^2;
M21=m2*r2^2+m2*r1*r2*cos(q2);
M12=M21;
M=[M11 M12;M21 M22];

V12=m2*r1*sin(q2);
V=[-V12*dq2 -V12*(dq1+dq2);V12*q1 0];
g1=(m1+m2)*r1*cos(q2)+m2*r2*cos(q1+q2);
g2=m2*r2*cos(q1+q2);
G=[g1;g2];

alfa=20;
w=M*alfa*de+V*alfa*e;

Gama=0.05;
ut=-e-w-0.5*1/Gama^2*(de+alfa*e);  
T=ut+M*ddqd+V*dqd+G;

sys(1)=T(1);
sys(2)=T(2);