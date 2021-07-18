clear all;
close all;

%First example on the paper by M.Rehan
A=[-2.548 9.1 0;
    1 -1 1;
    0 -14.2 0];
B=[1 0 0;
    0 1 0;
    0 0 1];
%P=sdpvar(3,3);
F=sdpvar(3,3);
M=sdpvar(3,3);

P=1000000*eye(3);

%FAI=(A'+F'*B')*P+P*(A+B*F);
FAI=A'*P+M'+P*A+M;   %M=PBF

%LMI description
%L1=set(P>0);
L2=set(FAI<0);
%LL=L1+L2;

solvesdp(L2);

%P=double(P);
M=double(M)

F=inv(P*B)*M