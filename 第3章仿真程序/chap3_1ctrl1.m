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
sizes.NumOutputs     = 1;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
thn=u(1);
dthn=u(2);
thd=u(3);dthd=cos(t);ddthd=-sin(t);

e=thn-thd;
de=dthn-dthd;

k=3;
Bn=10;Jn=3;
h1=k^2;
h2=2*k-Bn/Jn;

ut=Jn*(-h1*e-h2*de+Bn/Jn*dthd+ddthd);

sys(1)=ut;