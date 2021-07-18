close all;

figure(1);
subplot(211);
plot(t,x(:,1),'r',t,x(:,3),'k:','linewidth',2);
xlabel('time(s)');ylabel('x1 and its estimate');
legend('practical position','position estimation');
subplot(212);
plot(t,x(:,2),'r',t,x(:,4),'k:','linewidth',2);
xlabel('time(s)');ylabel('x2 and its estimate');
legend('practical speed','speed estimation');