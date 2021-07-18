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
sizes.NumOutputs     = 2;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
g=9.8;M=1.0;m=0.1;L=0.5;
I=1/12*m*L^2;  
l=1/2*L;
t1=m*(M+m)*g*l/[(M+m)*I+M*m*l^2];
t2=-m^2*g*l^2/[(m+M)*I+M*m*l^2];
t3=-m*l/[(M+m)*I+M*m*l^2];
t4=(I+m*l^2)/[(m+M)*I+M*m*l^2];

A=[0,1,0,0;
   t1,0,0,0;
   0,0,0,1;
   t2,0,0,0];
B=[0;t3;0;t4];

% P is solved by LMI
P=[7.4496    1.2493    1.0782    1.1384;   
   1.2493    0.3952    0.2108    0.3252;
   1.0782    0.2108    0.3854    0.2280;
   1.1384    0.3252    0.2280    0.4286];

deltaf=0.30;
epc0=0.5;

x=[u(1) u(2) u(3) u(4)]';

s=B'*P*x;
ueq=-inv(B'*P*B)*B'*P*A*x;

M=2;
if M==1
    un=-inv(B'*P*B)*(norm(B'*P*B)*deltaf+epc0)*sign(s);
elseif M==2                  %Saturated function 
        delta=0.05;
    	kk=1/delta;
       if abs(s)>delta
      	sats=sign(s);
       else
		sats=kk*s;
       end
    un=-inv(B'*P*B)*(norm(B'*P*B)*deltaf+epc0)*sats;
end
ut=un+ueq;
sys(1)=ut;
sys(2)=s;