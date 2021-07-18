%Discrete Reaching Law VSS Control based on Kalman Filter
clear all;
close all;

a=25;b=133;

ts=0.001;
A1=[0,1;0,-a];
B1=[0;b];
C1=[1,0];
D1=0;
[A,B,C,D]=c2dm(A1,B1,C1,D1,ts,'z');

x=[-0.5;-0.5];
yd_1=0;yd_2=0;

Q= 10*eye(2);           %Covariances of w
R=10;           %Covariances of v
P=B'*Q*B;       %Initial error covariance

for k=1:1:10000
   time(k)=k*ts;
   
   yd(k)=sin(k*ts);
   c=30;eq=150;q=300;
   Ce=[c,1];
   
%Using Waitui method   
   dyd(k)=(yd(k)-yd_1)/ts;
   dyd_1=(yd_1-yd_2)/ts;
   yd1(k)=2*yd(k)-yd_1;
   dyd1(k)=2*dyd(k)-dyd_1;
  
   Yd=[yd(k);dyd(k)];
   Yd1=[yd1(k);dyd1(k)];
   
   E=Yd-x;
   e(k)=E(1);
   de(k)=E(2);
   
   s(k)=Ce*E;
   ds(k)=-eq*ts*sign(s(k))-q*ts*s(k);
   
   u(k)=inv(Ce*B)*(Ce*Yd1-Ce*A*x-s(k)-ds(k));
	wn(k)=rands(1);       %Process noise on u
	u(k)=u(k)+wn(k);
   
   x=A*x+B*u(k);
   v(k)=0.015*rands(1);  %Measurement noise on y
   yv(k)=C*x+v(k);

 M=2;
 if M==1        %Kalman Filter
    Mn=P*C'/(C*P*C'+R);
    P=A*P*A'+B*Q*B'; 
    P=(eye(2)-Mn*C)*P;
    x=A*x+Mn*(yv(k)-C*A*x);
    ye(k)=C*x;
 elseif M==2    %No Filter
	 ye(k)=yv(k); 
    x(1)=ye(k);
 end
 
 
%Update Parameters
yd_2=yd_1;
yd_1=yd(k);
end

figure(1);
subplot(211);
plot(time,yv,'r','linewidth',2);
xlabel('Time(s)');ylabel('yv');
legend('signal with noise');
subplot(212);
plot(time,ye,'r','linewidth',2);
xlabel('Time(s)');ylabel('ye');
legend('filtered signal with kalman');

figure(2);
plot(time,yd,'r',time,ye,'b');
xlabel('Time(second)');ylabel('position tracking');
figure(3);
plot(time,s,'r');
xlabel('Time(second)');ylabel('Switch function s');
figure(4);
plot(e,de,'r',e,-c*e,'b');
xlabel('e');ylabel('de');
figure(5);
plot(time,u,'r');
xlabel('Time(second)');ylabel('u');