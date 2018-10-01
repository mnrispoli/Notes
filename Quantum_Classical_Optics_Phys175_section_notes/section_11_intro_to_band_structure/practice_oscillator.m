close all
clear all
clc


N=10000;
t=linspace(0,1,N);
dt=t(2)-t(1);
F=sin(40.*pi.*t.^2);
y=zeros([1,length(F)]);
y(1:end)=0;
a=y;
v=y;


gamma=0.1;
omega=2*pi*10

for n=3:N
    a(n)=F(n-1)-gamma*v(n-1)-y(n-1)*omega^2;
    v(n)=v(n-1)+a(n-1)*dt;
    y(n)=y(n-1)+v(n-1)*dt;
    %y(n)=(x(n)*dt^2 + 2*y(n-1) + gamma*dt*y(n-1)+y(n-2))/(1+gamma*dt+omega^2*dt^2);
end
figure()
plot(t,F)
hold on
plot(t,y)
axis([0 1 -1 1])
