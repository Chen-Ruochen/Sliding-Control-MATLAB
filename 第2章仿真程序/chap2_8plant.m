function dx=Plant(t,x,flag,para)
dx=zeros(2,1);
fx=-25*x(2);

ut=para(1);
dt=3.0*sin(t);
dx(1)=x(2);  
dx(2)=fx+133*ut+dt;