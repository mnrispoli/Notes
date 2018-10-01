clear all;
close all;
clc;

%numbers for etalon
c=3*10^8;
n=1.45;
d=0.5.*10^-3;
R=((n-1)/(n+1)).^2;


FSR=c./(2.*n.*d);
F=pi*sqrt(R)./(1-R);





nu=linspace(0,4*10^11,100000);
T=((2*F/pi).^2).*((1-R).^2)./(4*R)./(1+(2*F/pi).^2.*sin(pi.*nu./FSR).^2);
ET=T;
figure()
subplot(1,3,1)
plot(nu,T)
ylabel('Etalon Transmission')
xlabel('\nu (Hz)')
axis([nu(1) nu(end) 0 1])
grid on

c=3*10^8;
n=4;
d=0.25*10^-2;
R=((n-1)/(n+1)).^2;


FSR=c./(2.*n.*d);
F=pi*sqrt(R)./(1-R);
nu=linspace(0,4*10^11,100000);
T=((2*F/pi).^2).*((1-R).^2)./(4*R)./(1+(2*F/pi).^2.*sin(pi.*nu./FSR).^2);
LD=T;

subplot(1,3,2)
plot(nu,T)
ylabel('Laser Diode Transmission')
xlabel('\nu (Hz)')
axis([nu(1) nu(end) 0 1])
grid on

subplot(1,3,3)
plot(nu,LD.*ET)
ylabel('Combo Transmission')
xlabel('\nu (Hz)')
axis([nu(1) nu(end) 0 1])
grid on


set(gcf,'color','white')
