close all;

figure(1);
subplot(211);
plot(t,x(:,1),'k',t,x(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('position tracking');
legend('ideal position','position tracking');
subplot(212);
plot(t,cos(t),'k',t,x(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('speed tracking');
legend('ideal speed','speed tracking');

figure(2);
plot(t,f(:,1),'k',t,f(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('f approximation');
legend('ideal f','estimation of f');