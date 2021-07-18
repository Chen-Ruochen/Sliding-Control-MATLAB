close all;

figure(1);
c=15;

load testfile1;
plot(e,de,'y',e,-c'.*e,'k','linewidth',2);
hold on;
load testfile2;
plot(e,de,'b',e,-c'.*e,'k','linewidth',2);
hold on;
load testfile3;
plot(e,de,'g',e,-c'.*e,'k','linewidth',2);
hold on;
load testfile4;
plot(e,de,'r',e,-c'.*e,'k','linewidth',2);
xlabel('e');ylabel('de');

title('yellow:k=0, blue:k=10, green:k=20, red:k=30');