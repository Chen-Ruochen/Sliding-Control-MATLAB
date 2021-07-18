clear all;
close all;
a=25;b=133;
xk=zeros(2,1);
ut_1=0;
c=5;
T=0.001;
for k=1:1:6000
time(k)=k*T;
thd(k)=sin(k*T);
dthd(k)=cos(k*T);   
ddthd(k)=-sin(k*T);   

tSpan=[0 T];

para=ut_1;      % D/A
[tt,xx]=ode45('chap2_8plant',tSpan,xk,[],para);
xk=xx(length(xx),:);    % A/D
th(k)=xk(1);
dth(k)=xk(2);

e(k)=thd(k)-th(k);
de(k)=dthd(k)-dth(k);
s(k)=c*e(k)+de(k);

fx(k)=-25*xk(2);

xite=3.1;  % xite>max(dt)
M=1;
if M==1
   ut(k)=1/b*(-fx(k)+ddthd(k)+c*de(k)+xite*sign(s(k)));
elseif M==2                  %Saturated function 
        delta=0.05;
    	kk=1/delta;
       if abs(s(k))>delta
      	sats=sign(s(k));
       else
		sats=kk*s(k);
       end
   ut(k)=1/b*(-fx(k)+ddthd(k)+c*de(k)+xite*sats);
end
ut_1=ut(k);
end
figure(1);
subplot(211);
plot(time,thd,'k',time,th,'r:','linewidth',2);
xlabel('time(s)');ylabel('position tracking');
legend('ideal position signal','tracking position signal');
subplot(212);
plot(time,dthd,'k',time,dth,'r:','linewidth',2);
xlabel('time(s)');ylabel('speed tracking');
legend('ideal speed signal','tracking speed signal');
figure(2);
plot(thd-th,dthd-dth,'k:',thd-th,-c*(thd-th),'r','linewidth',2);    %Draw line(s=0)
xlabel('e');ylabel('de');
legend('ideal slding mode','phase trajectory');
figure(3);
plot(time,ut,'r','linewidth',2);
xlabel('time(s)');ylabel('Control input');