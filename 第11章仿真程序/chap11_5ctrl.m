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
sizes.NumOutputs     = 3;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
x1=u(1);
x2=u(2);
x3=u(3);

f0=[-0.05 0 0]';

B=[1 0 0;
    0 1 0;
    0 0 1];
F=[ -1.5075   -5.0500    0.0000;
   -5.0500   -0.5000    6.6000;
    0.0000    6.6000   -1.5000];

ut=F*[x1;x2;x3]-inv(B)*f0;

sys(1:3)=ut;