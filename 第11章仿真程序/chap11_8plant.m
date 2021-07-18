function dx=dym(t,x,flag,para)
global A B
dx=zeros(4,1); 

ut=para(1);
time=para(2);

%State equation for one link inverted pendulum
f=0.3*sin(time);
dx=A*x+B*(ut-f);