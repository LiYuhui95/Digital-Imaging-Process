I = imread('22.bmp');
[M,N] = size(I);
P = max(2*[M N]);% Padding size. 
F = fftshift(fft2(I,P,P));
close all;
figure(1),imshow(I,[]);
figure(2),imshow(log(1+abs(F)),[]);
%[X,Y] = ginput;
% Creat 11 pairs of notch reject filters
p = 1.0e+03 * [0.1755 1.4595; 0.2775 1.3515; 0.3835 1.2435; 0.4875 1.1335; 0.5895 1.0235; 0.6975 0.9115; 0.9075 0.6955; 1.0095 0.5815; 1.1175 0.4695; 1.2175 0.3675; 1.3255 0.2515];% locations of maxima, found by ginput
H = ones(P,P);
[DX, DY] = meshgrid(1:P);
D0 = 20;
n=1;
for k = 1:11
    Dk1 = sqrt((DX-p(k,1)).^2+(DY-p(k,2)).^2);
    Dk2 = sqrt((DX-P-2+p(k,1)).^2+(DY-P-2+p(k,2)).^2);
    H1 = 1./(1+(D0./Dk1).^(2*n));
    H2 = 1./(1+(D0./Dk2).^(2*n));
    H = H.*H1.*H2;
end
close all;
figure(1),clf
subplot(2,3,1),imshow(I),title('Original Image');
subplot(2,3,2),imshow(log(1+abs(F)),[]),title('Frequency');
subplot(2,3,3),imshow(H,[]);
% Filtering
G = H.*F;
g = real(ifft2(ifftshift(G)));% reverse
g = g(1:M,1:N);
subplot(2,3,4),imshow(log(1+abs(G)),[]);
subplot(2,3,5),imshow(g,[]),title('Notch Filter');
%Gabor Filetering
close all;
wavelength = 10; %wavelength, parameter
orientation = 11.25;
for k = 0:15
    [mag,phase] = imgaborfilt(g,wavelength,k * orientation);
    figure(1),clf
    subplot(2,3,1),imshow(g,[]),title('Original image');
    subplot(2,3,2),imshow(mag,[]),title('Gabor magnitude');
    subplot(2,3,3),imshow(phase,[]),title('Gabor phase');
    subplot(2,3,4),imshow(mag.*cos(phase),[]),title('Gabor real');
    subplot(2,3,5),imshow(mag.*sin(phase),[]),title('Gabor imaginary');
    saveas(figure(1),[num2str(k) '.jpg']);
    close all;
end

