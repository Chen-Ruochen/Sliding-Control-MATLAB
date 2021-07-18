clear all;
close all;

b=0.5;
c=5;
ts=0.001;
for k=1:1:10000
   t(k)=k*ts;
   E(k)=200*exp(-(t(k)-c)^2/(2*b^2));
end
figure(1);
plot(t,E,'linewidth',2);
xlabel('time(s)');
ylabel('Gaussian function');