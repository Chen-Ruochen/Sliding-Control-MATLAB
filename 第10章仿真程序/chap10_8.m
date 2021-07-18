%SMC controller based on decoupled disturbance compensator
clear all;
close all;

ts=0.001;
a=25;b=133;
sys=tf(b,[1,a,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

A0=[0,1;0,-a];
B0=[0;b];
C0=[1,0];
D0=0;
%Change transfer function to discrete position xiteuation
[A1,B1,C1,D1]=c2dm(A0,B0,C0,D0,ts,'z');
A=A1;
B=B1;
c=15;
C=[c,1];
q=0.80;              %0<q<1
g=0.95;

m=0.010;             %m>abs(d(k+1)-d(k))

xite=C*B*m/g+0.0010;  %xite>abs(C*B*m/g);0<xite/fai<q<1

x_1=[0.5;0];
s_1=0;
u_1=0;
d_1=0;ed_1=0;
xd_1=0;xd_2=0;dxd_1=0;

for k=1:1:10000
time(k)=k*ts;

d(k)=1.5*sin(2*pi*k*ts);
d_1=d(k);

x=A*x_1+B*(u_1+d(k));

xd(k)=sin(k*ts);

   dxd(k)=(xd(k)-xd_1)/ts;
   dxd_1=(xd_1-xd_2)/ts;
   xd1(k)=2*xd(k)-xd_1; %Using Waitui method   
   dxd1(k)=2*dxd(k)-dxd_1;
   Xd=[xd(k);dxd(k)];
   Xd1=[xd1(k);dxd1(k)];

	e(k)=x(1)-Xd(1);
	de(k)=x(2)-Xd(2);
	s(k)=C*(x-Xd);

   ed(k)=ed_1+inv(C*B)*g*(s(k)-q*s_1+xite*sign(s_1));

   u(k)=-ed(k)+inv(C*B)*(C*Xd1-C*A*x+q*s(k)-xite*sign(s(k)));

   xd_2=xd_1;xd_1=xd(k);
   dxd_1=dxd(k);   
   
    ed_1=ed(k);
	x_1=x;
	s_1=s(k);

	x1(k)=x(1);
	x2(k)=x(2);
	u_1=u(k);
end
figure(1);
subplot(211);
plot(time,xd,'k',time,x1,'r:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('Ideal position signal','tracking signal');
subplot(212);
plot(time,dxd,'k',time,x2,'r:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');
legend('Ideal speed signal','tracking signal');
figure(2);
plot(time,d,'k',time,ed,'r:','linewidth',2);
xlabel('time(s)');ylabel('d,ed');
legend('Practical d','Estimation d');
figure(3);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');
figure(4);
plot(e,de,'b',e,-C(1)*e,'r');
xlabel('e');ylabel('de');