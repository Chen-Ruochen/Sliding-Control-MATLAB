close all;

figure(1);
subplot(211);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('angle tracking');
legend('ideal position','angle tracking');
subplot(212);
plot(t,0.1*cos(t),'k',t,y(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('angle speed tracking');
legend('ideal angle speed','angle speed tracking');

figure(2);
plot(t,ut(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('Control input');

figure(3);
plot(t,h(:,1),'k',t,h(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('h and estiamted h');
legend('Switch part','fuzzy estination');