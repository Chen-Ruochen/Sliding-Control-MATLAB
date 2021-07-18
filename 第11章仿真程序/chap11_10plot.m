close all;

figure(1);
plot(t,x(:,1),'r',t,x(:,2),'b',t,x(:,3),'k','linewidth',2);
xlabel('time(s)');ylabel('x1,x2,x3');
legend('x1','x2','x3');

figure(2);
subplot(211);
plot(t,ut(:,1),'r',t,ut(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('u');
legend('u1','u2');
subplot(212);
plot(t,z(:,1),'r',t,z(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('z');
legend('z1','z2');

figure(3);
x1=x(:,1);
x2=x(:,2);
x3=x(:,3);
plot3(x1,x2,x3);
xlabel('x1');ylabel('x2');zlabel('x3');
grid on;

display('the last x is');
G=size(x,1);
x(G,:)