function [sys,x0,str,ts]=s_function(t,x,u,flag)
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
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0 0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
x1=u(1);
x2=u(2);
x3=u(3);
xp=[x1 x2 x3]';

z=[x(1) x(2)]';

C=[0.0497    1.0000         0;
       0         0    1.0000];
K=[10.4476    8.9989         0;
         0         0    9.4963];

dz=K*xp-z;
sys(1)=dz(1);
sys(2)=dz(2);
function sys=mdlOutputs(t,x,u)
z=[x(1) x(2)]';

x1=u(1);
x2=u(2);
x3=u(3);
xp=[x1 x2 x3]';
 
a=10;b=8/3;r=28;
  

f=[0 -x1*x3 x1*x2]';
 
A=[-a a 0;
    r -1 0;
    0 0 -b];

C=[0.0497    1.0000         0;
       0         0    1.0000];
K=[10.4476    8.9989         0;
         0         0    9.4963];

S=C*xp+z;

M=1;
if M==1
    xite=1.5;
    ut=-C*A*xp-C*f-K*xp+z-xite*S;
elseif M==2
    alfa1=0.50;niu=1.0;xite1=2.0;
    Xite=niu+xite1*(norm(S))^(alfa1-1);
    ut=-C*A*xp-C*f-K*xp+z-Xite*S;
end

sys(1)=ut(1);
sys(2)=ut(2);
sys(3)=z(1);
sys(4)=z(2);