function [sys,x0,str,ts]=exp_pidf(t,x,u,flag)
switch flag,
case 0           % initializations
    [sys,x0,str,ts] = mdlInitializeSizes;
case 2           % discrete states updates
    sys = mdlUpdates(x,u);
case 3           % computation of control signal
%    sys = mdlOutputs(t,x,u,kp,ki,kd,MTab);
    sys=mdlOutputs(t,x,u);
case {1, 4, 9}   % unused flag values
    sys = [];
otherwise        % error handling
    error(['Unhandled flag = ',num2str(flag)]);
end;

%==============================================================
% when flag=0, perform system initialization
%==============================================================
function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;        % read default control variables
sizes.NumContStates = 0; % no continuous states
sizes.NumDiscStates = 3; % 3 states
sizes.NumOutputs = 3;    % 1 output variables: control u(t) and state x(3)
sizes.NumInputs = 5;     % 5 input signals
sizes.DirFeedthrough = 1;% input reflected directly in output
sizes.NumSampleTimes = 1;% single sampling period
sys = simsizes(sizes);   % 
x0 = [0; 0; 0];          % zero initial states
str = []; 
ts = [-1 0];             % sampling period
%==============================================================
% when flag=2, updates the discrete states
%==============================================================
function sys = mdlUpdates(x,u)
	T=0.001;

sys=[(u(1)-u(2))/T;
     (u(2)-u(3))/T;
     (u(4)-u(5))/T];
   
%==============================================================
% when flag=3, computates the output signals
%==============================================================
function sys = mdlOutputs(t,x,u,kp,ki,kd,MTab)
	T=0.001;

   r=u(1);
   r_1=u(2);
   r_2=u(3);
   dr=x(1);
   dr_1=x(2);
   
   xp(1)=u(4);
   xp(2)=x(3);
   
   c=10;eq=5;q=30;
   Ce=[c,1];
   
   
A=[1.0000    0.0010;
   0    0.9753];
B =[0.0001;
    0.1314];

   %Using Waitui method   
   r1=2*r-r_1;
   dr1=2*dr-dr_1;
  
   R=[r;dr];
   R1=[r1;dr1];
   
   E=R-xp';
   e=E(1);
   de=E(2);
   
   s=Ce*E;
   
   ds=-eq*T*sign(s)-q*T*s;
	ut=inv(Ce*B)*(Ce*R1-Ce*A*xp'-s-ds);   

sys(1)=ut;
sys(2)=e;
sys(3)=de;