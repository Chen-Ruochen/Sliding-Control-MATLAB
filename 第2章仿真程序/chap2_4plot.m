close all;

figure(1);
subplot(211);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
legend('Ideal position signal','Position tracking');
xlabel('time(s)');ylabel('Position tracking');
subplot(212);
plot(t,0.1*cos(t),'k',t,y(:,3),'r:','linewidth',2);
legend('Ideal speed signal','Speed tracking');
xlabel('time(s)');ylabel('Speed tracking');

figure(2);
plot(t,ut(:,1),'k','linewidth',0.1);
xlabel('time(s)');ylabel('Control input');