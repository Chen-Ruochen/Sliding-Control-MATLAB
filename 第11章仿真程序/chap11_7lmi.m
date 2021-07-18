clear all;
close all;

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

X=sdpvar(4,4);
L=sdpvar(1,4);
M=sdpvar(4,4);

M=A*X-B*L+X*A'-L'*B';
F=set(M<0)+set(X>0);

solvesdp(F);

X=double(X);
L=double(L);

P=inv(X)

K=L*inv(X)

save Pfile A B P;