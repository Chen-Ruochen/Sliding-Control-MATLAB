close all;

figure(1);
plot(t,x(:,1),'r',t,x(:,2),'b','linewidth',2);
xlabel('time(s)');ylabel('State response');

figure(2);
plot(t,ut(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');

figure(3);
M=1;
q=3;p=5;
if M==1      %TSM
plot(x(:,1),x(:,2),'r',x(:,1),-(abs(x(:,1))).^(q/p).*sign(x(:,1)),'b','linewidth',2);
elseif M==2  %NTSM
plot(x(:,1),x(:,2),'r',x(:,1),(abs(-x(:,1))).^(q/p).*sign(-x(:,1)),'b','linewidth',2);
end   
xlabel('x1');ylabel('x2');