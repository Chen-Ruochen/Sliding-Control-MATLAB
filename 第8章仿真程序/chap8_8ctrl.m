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
sizes.NumOutputs     = 1;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];

function sys=mdlOutputs(t,x,u)
persistent a2

if t==0
   
a=newfis('fuzz_smc');

a=addvar(a,'input','s',[-3,3]);            %Parameter e
a=addmf(a,'input',1,'NB','zmf',[-3,-1]);
a=addmf(a,'input',1,'NS','trimf',[-3,-1,1]);
a=addmf(a,'input',1,'Z','trimf',[-2,0,2]);
a=addmf(a,'input',1,'PS','trimf',[-1,1,3]);
a=addmf(a,'input',1,'PB','smf',[1,3]);

a=addvar(a,'output','u',[-4,4]);          %Parameter u
a=addmf(a,'output',1,'NB','zmf',[-4,-1]);
a=addmf(a,'output',1,'NS','trimf',[-4,-2,1]);
a=addmf(a,'output',1,'Z','trimf',[-2,0,2]);
a=addmf(a,'output',1,'PS','trimf',[-1,2,4]);
a=addmf(a,'output',1,'PB','smf',[1,4]);

rulelist=[1 5 1 1;     %Edit rule base
          2 4 1 1;
          3 3 1 1;
          4 2 1 1;
          5 1 1 1];
          
a=addrule(a,rulelist);
%showrule(a)           %Show fuzzy rule base

a1=setfis(a,'DefuzzMethod','centroid');  %Defuzzy
writefis(a1,'fsmc');   %Save fuzzy system as "fsmc.fis"
a2=readfis('fsmc');

flag=1;
if flag==1
figure(1);
plotmf(a1,'input',1);
figure(2);
plotmf(a1,'output',1);
end

end

s=u(2)-u(1);

ut=evalfis([s],a2);     %Using fuzzy inference

sys(1)=ut;