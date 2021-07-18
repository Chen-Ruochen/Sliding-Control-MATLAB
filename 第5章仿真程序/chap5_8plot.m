close all;
figure(1);
subplot(211);
plot(t,sin(t),t,p(:,1),'k','linewidth',2);
xlabel('Time/s');ylabel('angle tracking');
legend('x1d','x1');
subplot(212);
plot(t,cos(t),t,p(:,2),'k','linewidth',2);
xlabel('Time/s');ylabel('angle speed tracking');
legend('dx1d','x2');

figure(2);
plot(t,p(:,1),'k',t,p(:,3),'r',t,p1(:,1),'b','linewidth',2);
xlabel('Time/s');ylabel('x1');
legend('x1','x1 estimation','measured x1');

figure(3);
subplot(211);
plot(t,p(:,1)-p(:,3),'r','linewidth',2);
xlabel('Time/s');ylabel('Estimation error of x1');
subplot(212);
plot(t,p(:,2)-p(:,4),'r','linewidth',2);
xlabel('Time/s');ylabel('Estimation error of x2');


figure(4);
plot(t,delta_data2,'k','linewidth',2);
xlabel('Time/s');ylabel('Varying measurement delay time');