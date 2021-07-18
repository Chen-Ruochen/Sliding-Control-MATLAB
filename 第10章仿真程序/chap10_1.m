clear all;
close all;

A=[1 0.0010;
   0 0.9753];
B=[-0.0001;
   -0.1314];
x=[0.5;0.5];

ts=0.001;
for k=1:1:2000
time(k)=k*ts;

c=5;q=10;ep=0.5;
C=[c 1];
s(k)=C*x;

M=2;
if M==1
	u(k)=-inv(C*B)*(C*A*x-(1-q*ts)*s(k)+ep*ts*sign(s(k)));
elseif M==2        %Saturated function
	delta=0.005;
	kk=1/delta;
	if s(k)>delta
		sats=1;
	elseif abs(s(k))<=delta
		sats=kk*s(k);
	elseif s(k)<-delta
		sats=-1;
	end
	u(k)=-inv(C*B)*(C*A*x-(1-q*ts)*s(k)+ep*ts*sats);
end

x=A*x+B*u(k);

x1(k)=x(1);
x2(k)=x(2);
end
figure(1);
plot(time,x1,'r',time,x2,'k','linewidth',2);
xlabel('time(s)');ylabel('x1,x2');
figure(2);
plot(time,s,'r','linewidth',2);
xlabel('time(s)');ylabel('s');
figure(3);
plot(time,u,'r','linewidth',2);
xlabel('time(s)');ylabel('u');
figure(4);
plot(x1,x2,'r',x1,-c*x1,'b','linewidth',2);
xlabel('x1');ylabel('x2');