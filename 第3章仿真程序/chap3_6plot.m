close all;

figure(1);
subplot(211);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('Ideal position signal','tracking signal');
subplot(212);
plot(t,y(:,1)-y(:,2),'k','linewidth',2);
xlabel('time');ylabel('position tracking error');
legend('position tracking error');

figure(2);
plot(t,ut(:,1),'k','linewidth',2);
xlabel('time');ylabel('control input');