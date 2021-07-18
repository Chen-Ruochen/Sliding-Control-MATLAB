close all;

figure(1);
subplot(211);
plot(t,x(:,1),'r',t,xp(:,1),'k:','linewidth',2);
xlabel('time(s)');ylabel('x1 estimation');
legend('x1','x1p');
subplot(212);
plot(t,x(:,2),'r',t,xp(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('x2 estimation');
legend('x2','x2p');

figure(2);
subplot(211);
plot(t,y(:,1),'r',t,y(:,3),'k:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('ideal position','position tracking');
subplot(212);
plot(t,y(:,2),'r',t,y(:,4),'k:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');
legend('ideal speed','speed tracking');

figure(3);
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');