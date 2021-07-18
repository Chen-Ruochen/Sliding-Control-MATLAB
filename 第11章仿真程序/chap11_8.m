%Single Link Inverted Pendulum Control: LMI
clear all;
close all;
global A B
load Pfile;
u_1=0;
xk=[-pi/6,0,5.0,0];   %Initial state
ts=0.02;   %Sampling time
for k=1:1:1000
time(k)=k*ts;
Tspan=[0 ts];

para(1)=u_1;
para(2)=time(k);
[t,x]=ode45('chap11_8plant',Tspan,xk,[],para);
xk=x(length(x),:);

x1(k)=xk(1);
x2(k)=xk(2);
x3(k)=xk(3);
x4(k)=xk(4);
x=[x1(k) x2(k) x3(k) x4(k)]';

s(k)=B'*P*x;

deltaf=0.30;
epc0=0.5;

ueq(k)=-inv(B'*P*B)*B'*P*A*x;

M=2;
if M==1
    un(k)=-inv(B'*P*B)*(norm(B'*P*B)*deltaf+epc0)*sign(s(k));
elseif M==2                  %Saturated function 
        delta=0.05;
    	kk=1/delta;
       if abs(s(k))>delta
      	sats=sign(s(k));
       else
		sats=kk*s(k);
       end
    un(k)=-inv(B'*P*B)*(norm(B'*P*B)*deltaf+epc0)*sats;
end
u(k)=ueq(k)+un(k);

u_1=u(k);
end
figure(1);
subplot(411);
plot(time,x1,'k','linewidth',2);      %Pendulum Angle
xlabel('time(s)');ylabel('Angle');
subplot(412);
plot(time,x2,'k','linewidth',2);      %Pendulum Angle Rate
xlabel('time(s)');ylabel('Angle rate');
subplot(413);
plot(time,x3,'k','linewidth',2);      %Car Position
xlabel('time(s)');ylabel('Cart position');
subplot(414);
plot(time,x4,'k','linewidth',2);      %Car Position Rate
xlabel('time(s)');ylabel('Cart rate');
figure(5);
plot(time,u,'k','linewidth',2);       %Force F change
xlabel('time(s)');ylabel('Control input');