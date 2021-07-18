close all;
figure(1);
plot(t,p(:,1),'k',t,p(:,3),'r',t,p1(:,1),'b','linewidth',2);
xlabel('Time/s');ylabel('x1');
legend('x1','x1 estimation','measured x1');

figure(2);
subplot(211);
plot(t,p(:,1)-p(:,3),'r','linewidth',2);
xlabel('Time/s');ylabel('Estimation error of x1');
subplot(212);
plot(t,p(:,2)-p(:,4),'r','linewidth',2);
xlabel('Time/s');ylabel('Estimation error of x2');

figure(3);
plot(t,delta_data1,'k','linewidth',2);
xlabel('Time/s');ylabel('Varying measurement delay time');