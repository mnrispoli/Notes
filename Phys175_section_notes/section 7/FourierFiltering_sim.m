clear all;
close all;
clc;

%% 2 D examples: fourier filtering
%A=im2double(imread('Albert_Einstein_Head.jpg'));
A=im2double(rgb2gray(imread('fft_figs\spark-chars.png')));
%A=im2double(rgb2gray(imread('fft_figs\rick_and_morty_s02_still.jpg')));
%A=im2double(rgb2gray(imread('fft_figs\Peanuts_gang.png')));
%A=im2double(rgb2gray(imread('fft_figs\xkcd.jpg')));
[mm,nn]=size(A);
mmc=round(mm/2);
nnc=round(nn/2);
mask=ones(size(A));
maskhp=mask;
masklp=mask;

hh=5;
mask(round(size(mask,1)/2)-hh:round(size(mask,1)/2)+hh,:)=0;

rr=25

for xx=(mmc-rr):(mmc+rr)
    for yy=nnc-rr:nnc+rr
        if (xx-mmc)^2+(yy-nnc)^2<rr^2
            maskhp(xx,yy)=0;
        end
    end
end

masklp=1-maskhp;


linx=1:size(mask,1);
liny=1:size(mask,2);
xx=linx'*ones(1,numel(liny));
yy=ones(numel(linx),1)*liny;
maskG=ceil(0.9.*sin(25.*2.*pi.*yy./numel(linx)))+1;

figure(1)
subplot(3,2,1)
imagesc(A);
colormap('gray')
axis('image')
set(gcf,'color','white')
title('original image')

subplot(3,2,2)
imagesc(1-mask);
axis('image')
title('mask')

B=fftshift(fft2(A));

subplot(3,2,3)
imagesc(imrotate(abs(fft2(B.*(masklp))),180))
axis('image')

subplot(3,2,4)
imagesc(imrotate(abs(fft2(B.*(1-mask))),180))
axis('image')

subplot(3,2,5)
imagesc(imrotate(abs(fft2(B.*(maskhp))),180))
axis('image')

subplot(3,2,6)
imagesc(imrotate(abs(fft2(B.*(maskG))),180))
axis('image')


