close all;

figure(1);
subplot(211);
plot(t,x(:,1),'r',t,x(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('Ideal angle signal','angle signal tracking');
subplot(212);
plot(t,0.1*cos(t),'r',t,x(:,3),'k:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');
legend('Ideal speed signal','Speed signal tracking');

figure(2);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');

figure(3);
subplot(211);
plot(t,f(:,1),'r',t,f(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('f and estiamted f');
legend('True f','Estimation f');
subplot(212);
plot(t,g(:,1),'r',t,g(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('g and estimated g');
legend('True g','Estimation g');