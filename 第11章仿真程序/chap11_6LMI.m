clear all;
close all;

%First example on the paper by M.Rehan
A=[-2.548 9.1 0;
    1 -1 1;
    0 -14.2 0];
B=[1 0 0;
    0 1 0;
    0 0 1];

L=[2 0 0;
   0 0 0;
   0 0 0];

P=sdpvar(3,3);
F=sdpvar(3,3);
M=sdpvar(3,3);

FAI=[A'*P+M'+P*A+M+L'*L P;P -eye(3)] ;   %M=PBF

%LMI description
L1=set(P>0);
L2=set(FAI<0);
LL=L1+L2;

solvesdp(LL);

P=double(P);
M=double(M)

F=inv(P*B)*M