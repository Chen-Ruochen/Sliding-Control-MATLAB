close all;

figure(1);
subplot(311);
plot(t,xr(:,1),'r',t,x(:,1),'b','linewidth',2);
xlabel('time(s)');ylabel('xr1,x1');
subplot(312);
plot(t,xr(:,2),'r',t,x(:,2),'b','linewidth',2);
xlabel('time(s)');ylabel('xr2,x2');
subplot(313);
plot(t,xr(:,3),'r',t,x(:,3),'b','linewidth',2);
xlabel('time(s)');ylabel('xr3,x3');

figure(2);
subplot(311);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('u1');
subplot(312);
plot(t,u(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('u2');
subplot(313);
plot(t,u(:,3),'r','linewidth',2);
xlabel('time(s)');ylabel('u3');