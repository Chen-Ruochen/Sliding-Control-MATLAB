clear all;
close all;
a=25;b=133;

ts=0.001;
A1=[0,1;0,-a];
B1=[0;b];
C1=[1,0];
D1=0;
[A,B,C,D]=c2dm(A1,B1,C1,D1,ts,'z');

x=[-0.5;-0.5];
r_1=0;r_2=0;
c=10;q=30;
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
M=1;
if M==1             %EXP reaching law
	eq(k)=15;
   ds(k)=-eq(k)*ts*sign(s(k))-q*ts*s(k);
   u(k)=inv(Ce*B)*(Ce*R1-Ce*A*x-s(k)-ds(k));
elseif M==2         %Adaptive trending law
   eq(k)=abs(s(k))/2;
%eq(k)=(2000-q)*abs(s(k))-1;
   
   ds(k)=-eq(k)*ts*sign(s(k))-q*ts*s(k);
   u(k)=inv(Ce*B)*(Ce*R1-Ce*A*x-s(k)-ds(k));
end
	h(k)=eq(k)*ts/(2-q*ts);

if u(k)>=10
   u(k)=10;
end
if u(k)<=-10
   u(k)=-10;
end

x=A*x+B*u(k);
y(k)=x(1);

%Update Parameters
r_2=r_1;
r_1=r(k);
end
figure(1)
plot(time,r,'r',time,y,'b','linewidth',2);
xlabel('Time(second)');ylabel('position tracking)');
figure(2)
plot(time,s,'r',time,h,'b',time,-h,'b','linewidth',2);
xlabel('Time(second)');ylabel('Switch function s');
figure(3)
plot(e,de,'r',e,-c*e,'b','linewidth',2);
xlabel('e');ylabel('de');
figure(4)
plot(time,u,'r','linewidth',2);
xlabel('Time(second)');ylabel('u');
figure(5);
plot(time,eq,'r','linewidth',2);
xlabel('time(s)');ylabel('adaptive eq');