close all;

figure(1);
subplot(211);
plot(t,xd(:,1),'r',t,x(:,1),'b','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
subplot(212);
plot(t,xd(:,1)-x(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Position tracking error');

figure(2);
subplot(211);
plot(t,cos(t),'r',t,x(:,2),'b','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');
subplot(212);
plot(t,cos(t)-x(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking error');

figure(3);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('control input');