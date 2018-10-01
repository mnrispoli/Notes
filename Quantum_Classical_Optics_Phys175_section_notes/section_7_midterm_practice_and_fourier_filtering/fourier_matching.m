clear all
%close all
clc


mask=zeros(500,500);
Nx=500;
Ny=500;

linx=1:size(mask,1);
linx=linx-mean(linx);
liny=1:size(mask,2);
liny=liny-mean(liny);
xx=linx'*ones(1,numel(liny));
yy=ones(numel(linx),1)*liny;


ff=besselj(1,sqrt(xx.^2+yy.^2)/5);
ff=sin((xx+yy/3)/5);
ff=exp(-(xx-50).^2./10^2).*exp(-(yy).^2./100^2);
ff=ff-exp(-(xx+50).^2./10^2).*exp(-(yy).^2./100^2);
ff=(atan(yy+50)-atan(yy-50)).*(atan(xx+200)-atan(xx-200));
ff=exp(-(yy-50).^2./10^2).*exp(-(xx).^2./100^2);


%ff=ff-mean(mean(ff));
figure(1)
imagesc(1-ff)
colormap('gray')
axis('square')

FF=abs(fftshift(fft2(ff)));
figure(2)
imagesc(1-FF(Nx/4:3*Nx/4,Ny/4:3*Ny/4))
colormap('gray')
axis('square')