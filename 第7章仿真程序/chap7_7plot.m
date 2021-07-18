close all;

figure(1);
subplot(211);
plot(t,y(:,1),'r',t,y(:,3),'--k','linewidth',2);
xlabel('time(s)');ylabel('position tracking');
legend('angle ideal signal','angle practical signal');
subplot(212);
plot(t,y(:,2),'r',t,y(:,4),'--k','linewidth',2);
xlabel('time(s)');ylabel('speed tracking');
legend('angle speed ideal signal','angle speed practical signal');
figure(2);
plot(t,ut(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('control input');