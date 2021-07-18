close all;

figure(1);
plot(t,x(:,1),'r',t,x(:,2),'-.b','linewidth',2);
xlabel('time(s)');ylabel('State response');
legend('x1','x2');

figure(2);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');

figure(3);
alfa0=2;beta0=1;
p0=9;q0=5;
plot(x(:,1),x(:,2),'r',x(:,1),-alfa0*x(:,1)-beta0*abs(x(:,1)).^(q0/p0).*sign(x(:,1)),'b','linewidth',2);
xlabel('x1');ylabel('x2');