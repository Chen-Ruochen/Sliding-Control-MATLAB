function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {1,2, 4, 9 }
    sys = [];
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
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[-1 0];
function sys=mdlOutputs(t,x,u)
x1d=sin(t);
alfa1=u(2);
x2b=u(3);
x1=u(4);
x2=u(5);

tol=0.01;
dalfa1=(x2b-alfa1)/tol;

z2=x2-alfa1;

f=-25*x2;b=133;
r=1.0;
c2=1.0+r;
ut=1/b*(-f+dalfa1-c2*z2);

sys(1)=ut;