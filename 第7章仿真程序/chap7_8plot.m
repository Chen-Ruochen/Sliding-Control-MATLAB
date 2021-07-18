close all;

figure(1);
subplot(311);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('thd and y');
legend('ideal position','position tracking');
subplot(312);
plot(t,cos(t),'k',t,y(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('dthd and dy');
legend('ideal speed','speed tracking');
subplot(313);
plot(t,-sin(t),'k',t,y(:,4),'r:','linewidth',2);
xlabel('time(s)');ylabel('ddthd and ddy');
legend('ideal acceleration','acceleration tracking');

figure(2);
subplot(311);
plot(t,y(:,2),'k',t,y1(:,1),'r:','linewidth',2);
xlabel('time(s)');ylabel('x1 and its estimate');
legend('ideal x1','estimation of x1');
subplot(312);
plot(t,y(:,3),'k',t,y1(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('x2 and its estimate');
legend('ideal x2','estimation of x2');
subplot(313);
plot(t,y(:,4),'k',t,y1(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('x3 and its estimate');
legend('ideal x3','estimation of x3');

figure(3);
plot(t,ut(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('Control input');
