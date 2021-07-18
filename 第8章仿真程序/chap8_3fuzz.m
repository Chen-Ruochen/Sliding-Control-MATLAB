close all
clear all;

a=newfis('fuzz_smc');

a=addvar(a,'input','s',1/25*[-25,25]);
a=addmf(a,'input',1,'N','trapmf',1/25*[-25,-25,-3,0]);
a=addmf(a,'input',1,'Z','trimf',1/25*[-3,0,3]);
a=addmf(a,'input',1,'P','trapmf',1/25*[0,3,25,25]);

% a=addvar(a,'output','Mu',20*[-5,5]);
% a=addmf(a,'output',1,'N','trapmf',20*[-5,-5,-3,0]);
% a=addmf(a,'output',1,'Z','trimf',20*[-3,0,3]);
% a=addmf(a,'output',1,'P','trapmf',20*[0,3,5,5]);

a=addvar(a,'output','Mu',[-1,1]);
a=addmf(a,'output',1,'N','trapmf',[-1,-1,-0.5,0]);
a=addmf(a,'output',1,'Z','trapmf',[0,0.1,0.2,0.3]);
a=addmf(a,'output',1,'P','trapmf',[0,0.5,1,1]);

rulelist=[1 3 1 1;
          2 2 1 1;
          3 3 1 1];

a=addrule(a,rulelist);
showrule(a)                         %Show fuzzy rule base

a1=setfis(a,'DefuzzMethod','centroid');  %Defuzzy
a1=setfis(a,'DefuzzMethod','lom');  %Defuzzy
writefis(a1,'fsmc');                %Save fuzzy system as "fsmc.fis"
a2=readfis('fsmc');
ruleview(a2);

figure(1);
plotmf(a,'input',1);
figure(2);
plotmf(a,'output',1);