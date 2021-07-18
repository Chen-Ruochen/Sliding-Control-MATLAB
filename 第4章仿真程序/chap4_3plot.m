close all;

figure(1);
subplot(211);
plot(t,yd1(:,1),'r',t,y(:,1),'k:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking of link 1');
legend('ideal position for link 1','position tracking for link 1');
subplot(212);
plot(t,yd2(:,1),'r',t,y(:,3),'k:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking of link 2');
legend('ideal position for link 2','position tracking for link 2');

figure(2);
subplot(211);
plot(t,yd1(:,2),'r',t,y(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking of link 2');
legend('ideal speed for link 1','speed tracking for link 1');
subplot(212);
plot(t,yd2(:,2),'r',t,y(:,4),'k:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking of link 2');
legend('ideal speed for link 2','speed tracking for link 2');