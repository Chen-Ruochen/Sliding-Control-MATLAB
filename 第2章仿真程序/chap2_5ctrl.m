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
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
thd=u(1);    
dthd=cos(t);
ddthd=-sin(t);

th=u(2);
dth=u(3);

c=15;
e=thd-th;
de=dthd-dth;
s=c*e+de;

D=50;
xite=D+1.5;

fx=-25*dth;
b=133;

M=3;
if M==1           %Switch function
   ut=1/b*(-fx+ddthd+c*(dthd-dth)+xite*sign(s));
elseif M==2       %Saturated function
   fai=0.20;
   if abs(s)<=fai
      sat=s/fai;
   else
      sat=sign(s);
   end
   ut=1/b*(-fx+ddthd+c*(dthd-dth)+xite*sat);
elseif M==3       %Relay function
   delta=0.015;
   rs=s/(abs(s)+delta);
   ut=1/b*(-fx+ddthd+c*(dthd-dth)+xite*rs);
end
sys(1)=ut;
sys(2)=e;
sys(3)=de;