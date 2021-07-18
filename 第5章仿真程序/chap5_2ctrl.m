function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {1, 2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
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
thd=u(1);dthd=cos(t);ddthd=-sin(t);
th=u(2);
dth=u(3);
dp=u(5);
b=0.15;a=5;

e=thd-th;
de=dthd-dth;
c=15;
s=c*e+de;

xite=5.0;
M=2;
if M==1
    ut=1/a*(ddthd+b*dth+c*de+dp+xite*sign(s));
elseif M==2                  %Saturated function 
        delta=0.10;
    	kk=1/delta;
       if abs(s)>delta
      	sats=sign(s);
       else
		sats=kk*s;
       end
    ut=1/a*(ddthd+b*dth+c*de+dp+xite*sign(s));
end
sys(1)=ut;