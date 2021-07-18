close all;

figure(1);
subplot(211);
plot(t,y(:,1),'b',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('Position tracking');
legend('Desired position signal','Tracking position signal');
subplot(212);
plot(t,0.1*cos(t),'b',t,y(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('Speed tracking');
legend('Desired speed signal','Tracking speed signal');

figure(2);
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');

figure(3);
subplot(311);
plot(t,fai(:,1),'b',t,fai(:,4),'r:','linewidth',2);
xlabel('time(s)');ylabel('\psi_1');

subplot(312);
plot(t,fai(:,2),'b',t,fai(:,5),'r:','linewidth',2);
xlabel('time(s)');ylabel('\psi_2');

subplot(313);
plot(t,fai(:,3),'b',t,fai(:,6),'r:','linewidth',2);
xlabel('time(s)');ylabel('\psi_3');

