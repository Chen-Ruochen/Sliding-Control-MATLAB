close all;

figure(1);
subplot(211);
plot(t,y(:,1),'r',t,y(:,2),'-.k','linewidth',2);
xlabel('time(s)');ylabel('angle tracking');
legend('ideal angle signal','tracking signal');
subplot(212);
plot(t,cos(t),'r',t,y(:,3),'-.k','linewidth',2);
xlabel('time(s)');ylabel('speed tracking');
legend('ideal speed signal','tracking signal');

figure(2);
plot(t,ut(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('Control input,u');

figure(3);
plot(t,y(:,3),'r',t,deltap(:,1),'-.k','linewidth',2);
xlabel('time(s)');ylabel('delta');
legend('true delta','delta estimation');