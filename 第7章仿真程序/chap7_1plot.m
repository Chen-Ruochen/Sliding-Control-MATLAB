close all;

figure(1);
subplot(211);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
c
subplot(212);
plot(t,cos(t),'k',t,y(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');
legend('ideal speed signal','tracking signal');

figure(2);
plot(t,u,'k','linewidth',2);
xlabel('time(s)');ylabel('initial control input');

figure(3);
plot(t,tol,'k','linewidth',2);
xlabel('time(s)');ylabel('practical control input');