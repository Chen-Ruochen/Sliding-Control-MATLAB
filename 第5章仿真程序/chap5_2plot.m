close all;

figure(1);
subplot(211);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
legend('ideal position','tracking posotion');
subplot(212);
plot(t,cos(t),'k',t,y(:,3),'r:','linewidth',2);
legend('ideal speed','tracking speed');

figure(2);
subplot(211);
plot(t,p(:,3),'k',t,p(:,4),'r:','linewidth',2);
xlabel('time(s)');ylabel('d and its estimate');
legend('d','Estimate d');
subplot(212);
plot(t,p(:,3)-p(:,4),'r','linewidth',2);
xlabel('time(s)');ylabel('error between d and its estimate');
legend('Estimate error of d');

figure(3);
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');