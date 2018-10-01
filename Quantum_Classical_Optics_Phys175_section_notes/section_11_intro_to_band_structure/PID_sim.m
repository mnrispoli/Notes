%Matthew Rispoli
% 4/18/2017
% Section 11 PID simulation

clear all
%close all
clc


%This will be a super trivial version of a system where we will consider
%driving a system with some delay with a sinusoidal frequency.

ts=200;
t=[zeros(1,ts) linspace(0,1,10000)];
TN=length(t);
x=sin(2.*pi.*t);

%square pulse
%x(1:TN/2)=0;
%x(TN/2+1:end)=0.5;

%x(TN/2+100:TN/2+500)=0;
x=0.5*sin(100.*pi.*t.^2)

CF=TN/30;
LPMask=zeros(1,TN);
LPMask(1:CF/2)=1;
LPMask(TN-CF/2:end)=1;

xlp=real(ifft(fft(x).*LPMask));
xlp(1:ts)=0;


y=zeros(1,length(t));
xtilde=y;
e=xlp-y;


figure(234)

Kp=0.3;
%Ki=0.5;
Ki=0.015
%Kd=-0.25;
Kd=0

y=zeros(1,length(t));
xtilde=y;
e=xlp-y;

%for oscillator
gamma=1;
omega=2;


%delay must be two for damped oscillator
delayT=2;

dt=t(end)-t(end-1);
for tt=delayT+1:length(t)-1
    e(tt)=xlp(tt)-y(tt);
    
    %xtilde is my driving force
    %xtilde(tt+1)=(Kp*e(tt)+Kd*(e(tt)-e(tt-1))+Ki*sum(e(1:tt)));
    xtilde(tt+1)=x(tt);
    %y is how my system responds
    %in this case y is linear
    %y(tt+1)=xtilde(tt+1);
    
    %in this case y is the solution for lorentz oscillator
    y(tt+1)=(xtilde(tt+1)+(gamma+2)*y(tt)-y(tt-1))/(1+gamma+omega^2);
end

hold off
plot(x)
hold on
plot(y)
hold on

axis([0 length(t) -1 1])


