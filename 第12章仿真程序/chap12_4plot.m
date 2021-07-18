close all;

figure(1);
subplot(211);
plot(t,y(:,1),'r',t,y(:,2),'-.b','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
subplot(212);
plot(t,cos(t),'r',t,y(:,3),'-.b','linewidth',2);
xlabel('time(s)');ylabel('Speedracking');

figure(2);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');