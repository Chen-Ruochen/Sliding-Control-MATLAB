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
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
x1d=u(1);
dx1d=cos(t);ddx1d=-sin(t);
x1p=u(2);x2p=u(3);x3p=u(4);

J=10;b=1/J;

ep=x1p-x1d;
dep=x2p-dx1d;
c=50;
sp=c*ep+dep;
fp=x3p;

vp=c*dep-ddx1d;
kg=10;
ut=1/b*(-kg*sp-vp-fp);

sys(1)=ut;