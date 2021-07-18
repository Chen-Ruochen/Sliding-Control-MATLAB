clear all;
close all;

a=10;b=8/3;r=28;

A=[-a a 0;
    r -1 0;
    0 0 -b];
B=[0 0;
   1 0;
   0 1];

M=sdpvar(3,3);

C1=sdpvar(2,1);

C=[C1,eye(2)];

M=A-B*C*A;
F=set((M+M')<0);
 
solvesdp(F);

M=double(M)

display('the eigvalues of M is ');
eig(M)
display('the eigvalues of M+MT is ');
eig(M+M')

C=double(C)