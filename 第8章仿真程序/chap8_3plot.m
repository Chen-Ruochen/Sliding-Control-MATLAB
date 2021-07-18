close all;

figure(1);
subplot(211);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('Ideal position','Position tracking');
subplot(212);
plot(t,cos(t),'k',t,y(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');
legend('Ideal speed','Speed tracking');

figure(2);
plot(t,ut,'r','linewidth',2);
xlabel('time(s)');ylabel('control input');

figure(3);
plot(t,y(:,4),'r','linewidth',2);
xlabel('time(s)');ylabel('Disturbance');

figure(4);
plot(t,miu(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Membership function degree');