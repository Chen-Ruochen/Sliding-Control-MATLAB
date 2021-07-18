clear all;
close all;

a=25;b=133;
A1=[0,1;0,-a];
B1=[0;b];
C1=[1,0];
D1=0;

ts=0.001;
[A,B,C,D]=c2dm(A1,B1,C1,D1,ts,'z');

c=20;
Ce=[c,1];
x=[0.5;0.5];

ts=0.001;
for k=1:1:1000
time(k)=k*ts;

   s(k)=Ce*x;
   x1(k)=x(1);
   x2(k)=x(2);
   
	f0=2*abs(s(k))/(abs(Ce*B)*(abs(x1(k))+abs(x2(k)))+1.0);
   	deta1=0.5*f0*(Ce*B)*(Ce*B)*abs(x1(k))*(abs(x1(k))+abs(x2(k)));
	deta2=0.5*f0*(Ce*B)*(Ce*B)*abs(x2(k))*(abs(x1(k))+abs(x2(k)));
   
	cond1=Ce*B*s(k)*x1(k);
if cond1<-deta1
   f1=f0;
elseif cond1>deta1
   f1=-f0;
end

cond2=Ce*B*s(k)*x2(k);
if cond2<-deta2
   f2=f0;
elseif cond2>deta2
   f2=-f0;
end
    
Fd=[f1,f2];
ueq(k)=-1/(Ce*B)*Ce*(A-eye(2))*x;
u(k)=ueq(k)+Fd*x;

x=A*x+B*u(k);

end
figure(1);
plot(time,x1,'r','linewidth',2);
xlabel('time(s)');ylabel('x1');
figure(2);
plot(time,x2,'r','linewidth',2);
xlabel('time(s)');ylabel('x2');
figure(3);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('control input,u');
figure(4);
plot(x1,x2,'r',x1,-c*x1,'b','linewidth',2);
xlabel('x1');ylabel('x2');