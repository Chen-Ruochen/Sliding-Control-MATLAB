function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
persistent s0
e=u(1);
de=u(2);

c=150;
thd=sin(2*pi*t);
dthd=2*pi*cos(2*pi*t);
ddthd=-(2*pi)^2*sin(2*pi*t);

x1=thd-e;
x2=dthd-de;

fx=-25*x2;b=133;

s=c*e+de;

D=200;xite=1.0;

M=2;
if M==1
   K=D+xite;
elseif M==2    %Estimation for K with fuzzy
   K=abs(u(3))+xite;
end

ut=1/b*(-fx+ddthd+c*de+K*sign(s));

sys(1)=ut;
sys(2)=s;
sys(3)=K;