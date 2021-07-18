clear all;
close all;

xite=5.0;
ts=0.01;
for k=1:1:4000;

s(k)=k*ts-20;

y1(k)=xite*sign(s(k));

epc=0.5;
y2(k)=xite*tanh(s(k)/epc);
end

figure(1);
plot(s,y1,'r',s,y2,'k','linewidth',2);
xlabel('s');ylabel('y');
legend('Switch function','Tanh function');