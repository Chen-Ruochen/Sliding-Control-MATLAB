close all;

figure(1);
subplot(311);
plot(t,x(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('x1');
subplot(312);
plot(t,x(:,2),'r','linewidth',2);
xlabel('time(s)');ylabel('x2');
subplot(313);
plot(t,x(:,3),'r','linewidth',2);
xlabel('time(s)');ylabel('x3');

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