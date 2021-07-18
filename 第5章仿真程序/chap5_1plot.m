close all;

figure(1);
plot(t,p(:,3),'k',t,p(:,4),'r:','linewidth',2);
xlabel('time(s)');ylabel('d and its estimate');
legend('d','Estimate d');