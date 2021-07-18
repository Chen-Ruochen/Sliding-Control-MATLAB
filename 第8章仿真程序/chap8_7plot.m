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
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');

figure(3);
plot(t,f(:,1),'k',t,f(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('f and estiamted f');
legend('ideal f','estimation of f');

figure(4);
plot(t,g(:,1),'k',t,g(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('g and estimated g');
legend('ideal g','estimation of g');