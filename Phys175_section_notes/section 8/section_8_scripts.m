clear all;
close all;
clc;

%eigenstates of harmonic oscillator with some unitless stuff put in hbar
%omega/m = 1
PsiHO = @(x,n) (1./sqrt((2.^n).*factorial(n))).*((1/pi)^(1/4)).*hermiteH(n,x).*exp(-x.^2./2);


x=linspace(-20,20,500);
figure(11)
plot(x,(1/2).*x.^2)
hold on
plot(x,PsiHO(x,0))
hold on
plot(x,PsiHO(x,1)+1)
hold on
plot(x,PsiHO(x,2)+2)
hold on
plot(x,PsiHO(x,3)+3)
hold on
plot(x,PsiHO(x,4)+4)
axis([-10 10 -1 5])
grid on
xlabel('x (a.u.)')
ylabel('energy & \Psi')
set(gcf,'color','white')
%% create some test psi's
%shifted gaussian
TestPsi = @(x,S,D) sqrt((1/sqrt(2.*pi.*S.^2)).*exp(-(x-D).^2/(S.^2)/2));

figure(22)
plot(x,(1/2).*(x.^2))
hold on
plot(x,TestPsi(x,1,3))
axis([-20 20 -1 5])
grid on
set(gcf,'color','white')

dx=x(2)-x(1);

%% find basis functions
% create basis function of harmonic oscillator
NFs=101;
BasisFs=zeros(length(x),51);
for nn=1:NFs
    BasisFs(:,nn)=PsiHO(x,nn-1).*(x(2)-x(1));
    nn
end

%% Decomposing into basis functions
Cns=ctranspose(PsiHO(x-3,0)')*BasisFs;
Cns=ctranspose(TestPsi(x,1,5)')*BasisFs;
Cns=ctranspose(PsiHO(x-3.5,0)')*BasisFs;

Cns2=ctranspose(TestPsi(x,3,0)')*BasisFs;

%find amplitudes from decomposition
figure(234)
subplot(2,1,1)
plot(Cns.^2,'o--')
ylabel('|\langle \Psi | n \rangle |^2')
title('Off Center Gaussian')
xlabel('n')
grid on
hold off


subplot(2,1,2)
plot(Cns2.^2,'o--')
hold off
ylabel('|\langle \Psi | n \rangle |^2')
title('Centered Gaussian')
xlabel('n')
set(gcf,'color','white')
grid on


%% Time Evolution

%evolve in time
ws=exp(-i*([1:NFs]-1/2).*2.*pi./1000);

figure(1)
for ii=1:1000
plot(x,abs((Cns.*ws.^(ii))*BasisFs')./dx)
title('time evolution of \psi')
xlabel('x')
ylabel(' | |\psi (x,t)\rangle |')
set(gcf,'color','white')
grid on
axis([-10 10 0 1])
pause(.01)
end

%{
figure(12)
for ii=1:1000
plot(x,(1/2).*x.^2,x,abs((Cns.*ws.^(ii))*BasisFs')./dx+(1/2).*(5.*cos(2.*pi.*ii./1000)).^2)
axis([-10 10 0 25])
pause(.01)
end
%}
%% Coh State
%Actual coherent state!
CohSt = @(alpha,N) exp(-abs(alpha).^2/2).*alpha.^([1:N]-1)./sqrt(factorial([1:N]-1))
CohCns=CohSt(5/2,NFs);
figure(2)
plot(x,BasisFs*CohCns'./dx,x,PsiHO(x-3.5,0))
xlabel('x')
ylabel(' | |\psi (x,0)\rangle |')
title('Coherent State, offset |0\rangle')
set(gcf,'color','white')
grid on
%%
figure(3)
for ii=1:100
    psi=(CohCns.*exp(-i*([1:NFs]-1/2).*2.*pi.*ii./100));
    
plot(x,abs(psi*BasisFs')./dx)
axis([-10 10 0 1])
title('time evolution of \psi')
xlabel('x')
ylabel(' | |\psi (x,t)\rangle |')
set(gcf,'color','white')
grid on
pause(.1)
end
