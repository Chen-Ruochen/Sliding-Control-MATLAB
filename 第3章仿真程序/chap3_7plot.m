close all;

figure(1);
subplot(211);
plot(t,y(:,1),'r',t,y(:,3),'b','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
subplot(212);
plot(t,y(:,2),'r',t,y(:,4),'b','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');

figure(2);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');