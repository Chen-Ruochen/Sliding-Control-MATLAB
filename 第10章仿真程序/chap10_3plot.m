close all;

figure(1);
plot(t,y(:,1),'r',t,y(:,2),'b','linewidth',2);
xlabel('Time(second)');ylabel('(r and y)');
legend('ideal position signal','position tracking');

figure(2);
c=10;
plot(e,de,'r',e,-c*e,'b','linewidth',2);
xlabel('e');ylabel('de');

figure(3);
plot(t,u,'r','linewidth',2);
xlabel('time(s)');ylabel('control input,u');