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
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
x1=u(1);
x2=u(2);

g=9.8;mc=1.0;m=0.1;l=0.5;
S=l*(4/3-m*(cos(x1))^2/(mc+m));
fx=g*sin(x1)-m*l*x2^2*cos(x1)*sin(x1)/(mc+m);
fx=fx/S;
gx=cos(x1)/(mc+m);
gx=gx/S;


D=2.0;
beta=1.0;
xite=0.10;

q=3;p=5;

M=2;
if M==1       %TSM
   T1=abs(x1)^(q/p)*sign(x1);   
   T2=abs(x1)^(q/p-1)*sign(x1);
   s=x2+beta*T1;   
   delta=0.005;kk=1/delta;
  	if s>delta
 		sats=1;
 	elseif abs(s)<=delta
 		sats=kk*s;
 	elseif s<-delta
 		sats=-1;
    end
    ut=-inv(gx)*(fx+beta*q/p*T2*x2+(D+xite)*sats);
elseif M==2   %NTSM
   T1=abs(x2)^(p/q)*sign(x2);
   T2=abs(x2)^(2-p/q)*sign(x2);
   s=x1+1/beta*T1;
   delta=0.001;kk=1/delta;
  	if s>delta
 		sats=1;
 	elseif abs(s)<=delta
 		sats=kk*s;
 	elseif s<-delta
 		sats=-1;
    end
    ut=-inv(gx)*(fx+beta*q/p*T2+(D+xite)*sats);
end
sys(1)=ut;