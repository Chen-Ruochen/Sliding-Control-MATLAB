clear all;
close all;

a=25;b=133;
ts=0.001;
A1=[0,1;0,-a];
B1=[0;b];
C1=[1,0];
D1=0;
[A,B,C,D]=c2dm(A1,B1,C1,D1,ts,'z');

x=[-0.8;-0.5];
r_1=0;r_2=0;

c=5;
eq=5;
q=30;
Ce=[c,1];
for k=1:1:2000
	time(k)=k*ts;
   r(k)=1.0;
   
   %Using Waitui method   
   dr(k)=(r(k)-r_1)/ts;
   dr_1=(r_1-r_2)/ts;
   r1(k)=2*r(k)-r_1;
   dr1(k)=2*dr(k)-dr_1;
  
   R=[r(k);dr(k)];
   R1=[r1(k);dr1(k)];
   
   E=R-x;
   e(k)=E(1);
   de(k)=E(2);
   
   s(k)=Ce*E;
   
   X1=abs(e(k))+abs(de(k));
   
M=3;   
if M==1             %EXP reaching law
   ds(k)=-eq*ts*sign(s(k))-q*ts*s(k);
   u(k)=inv(Ce*B)*(Ce*R1-Ce*A*x-s(k)-ds(k));
elseif M==2         %Variable rate reachine law
   ds(k)=-eq*ts*X1*sign(s(k));
   u(k)=inv(Ce*B)*(Ce*R1-Ce*A*x-s(k)-ds(k));
elseif M==3         %Coposite reaching law
   k0=0.60;
   if X1>k0          %EXP reachine law
	   ds(k)=-eq*ts*sign(s(k))-q*ts*s(k);
	   u(k)=inv(Ce*B)*(Ce*R1-Ce*A*x-s(k)-ds(k));
   elseif X1<=k0     %Variable rate reachine law
   ds(k)=-eq*ts*X1*sign(s(k));
   u(k)=inv(Ce*B)*(Ce*R1-Ce*A*x-s(k)-ds(k));
   end
end

x=A*x+B*u(k);
y(k)=x(1);

%Update Parameters
r_2=r_1;
r_1=r(k);
end
figure(1)
plot(time,r,'r',time,y,'b','linewidth',2);
xlabel('Time(second)');ylabel('Position tracking');
figure(2)
plot(time,s,'r','linewidth',2);
xlabel('Time(second)');ylabel('Switch function s');
figure(3)
plot(e,de,'r',e,-c*e,'b','linewidth',2);
xlabel('e');ylabel('de');
figure(4)
plot(time,u,'r','linewidth',2);
xlabel('Time(second)');ylabel('control input,u');