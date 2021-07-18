%VSS controller based on decoupled disturbance compensator
clear all;
close all;

ts=0.001;
a=25;
b=133;
sys=tf(b,[1,a,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

A=[0,1;0,-a];
B=[0;b];
C=[1,0];
D=0;
%Change transfer function to discrete position equation
[A1,B1,C1,D1]=c2dm(A,B,C,D,ts,'z');
A=A1;
b=B1;
c=15;
Ce=[c,1];
q=0.80;              %0<q<1

d_up=1.5;
eq=Ce*b*d_up+0.10;  %eq>abs(Ce*b*m/g);0<eq/fai<q<1

x_1=[0.15;0];
s_1=0;
u_1=0;
d_1=0;ed_1=0;
r_1=0;r_2=0;dr_1=0;

for k=1:1:10000
time(k)=k*ts;

d(k)=1.5*sin(k*ts);

x=A*x_1+b*(u_1+d(k));

r(k)=sin(k*ts);
%Using Waitui method   
   dr(k)=(r(k)-r_1)/ts;
   dr_1=(r_1-r_2)/ts;
   r1(k)=2*r(k)-r_1;
   dr1(k)=2*dr(k)-dr_1;

   xd=[r(k);dr(k)];
   xd1=[r1(k);dr1(k)];

	e(k)=x(1)-r(k);
	de(k)=x(2)-dr(k);
	s(k)=c*e(k)+de(k);

    u(k)=inv(Ce*b)*(Ce*xd1-Ce*A*x+q*s(k)-eq*sign(s(k)));

    r_2=r_1;r_1=r(k);
    dr_1=dr(k);   
   
	x_1=x;
	s_1=s(k);

	x1(k)=x(1);
	x2(k)=x(2);
	u_1=u(k);
end
figure(1);
subplot(211);
plot(time,r,'k',time,x1,'r:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('Ideal position signal','tracking signal');
subplot(212);
plot(time,dr,'k',time,x2,'r:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');
legend('Ideal speed signal','tracking signal');

figure(2);
plot(time,u,'k','linewidth',2);
xlabel('time(s)');ylabel('u');
figure(3);
plot(e,de,'k',e,-Ce(1)*e,'r','linewidth',2);
xlabel('e');ylabel('de');