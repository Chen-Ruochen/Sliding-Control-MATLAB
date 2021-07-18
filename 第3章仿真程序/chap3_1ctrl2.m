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
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
Bn=10;Jn=3;
lamt=Bn/Jn;

Jm=2.5;JM=3.5;
Bm=7;BM=13;

dM=0.10;
K=10; 

thn=u(1);dthn=u(2); 
nu=u(3);
th=u(4);dth=u(5);

en=th-thn;
den=dth-dthn;

s=den+lamt*en;

temp0=(1/Jn)*nu-lamt*dth;
  
Ja=1/2*(JM+Jm);
Ba=1/2*(BM+Bm);
  
h=dM+1/2*(JM-Jm)*abs(temp0)+1/2*(BM-Bm)*abs(dth);

ut=-K*s-h*sign(s)+Ja*((1/Jn)*nu-lamt*dth)+Ba*dth;

sys(1)=ut;