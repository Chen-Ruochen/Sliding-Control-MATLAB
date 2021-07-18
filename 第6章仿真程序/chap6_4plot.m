close all;

figure(1);
subplot(211);
plot(t,y(:,1),'r',t,y(:,2),'b:','linewidth',2);
xlabel('time(s)');ylabel('position tracking');
legend('ideal position','practical position');
subplot(212);
plot(t,cos(t),'r',t,y(:,3),'b:','linewidth',2);
xlabel('time(s)');ylabel('speed tracking');
legend('ideal speed','practical speed');

figure(2);
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');

figure(3);
subplot(211);
plot(t,x2b(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('x2b');
subplot(212);
plot(t,alfa1(:,1),'b','linewidth',2);
xlabel('time(s)');ylabel('alfa1');