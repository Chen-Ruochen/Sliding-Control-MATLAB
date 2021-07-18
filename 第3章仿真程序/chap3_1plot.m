close all;

figure(1);
plot(t,sin(t),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('Ideal position signal','tracking signal');


figure(2);
plot(t,cos(t),'k',t,y(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');
legend('Ideal speed signal','tracking signal');

figure(3);
plot(t,ut,'r','linewidth',2);
xlabel('time(s)');ylabel('control input');