close all, clear all
%create some rectangle
% Construct 2D sine wave
[X, Y] = meshgrid(1:256);
f1 = cos(2*pi*0.05*X);
figure(1),
%compare the frequency of my_DFT and fft2
subplot(2,2,1),imshow(f1,[])
f1_my_DFT = My_DFT(256) * f1 * My_DFT(256);%compute and visualize the DFT of f using my_DFT
f1_my_DFT = fftshift(f1_my_DFT);%balance the image
subplot(2,2,2),imshow(abs(f1_my_DFT),[]);%show the margin
f1_DFT = fftn(f1);%use the fftn function of matlab
f1_DFT = fftshift(f1_DFT);%balance the image
subplot(2,2,3),imshow(f1,[]);
subplot(2,2,4),imshow(abs(f1_DFT),[]);%show the margin
figure(2),
%construct 2D sine wave
f2 = cos(2*pi*0.1*Y);
subplot(2,3,1),imshow(f1,[]);
subplot(2,3,4),imshow(f2,[]);
% Compute and visualize the 30-by-30 DFT of f
f2_DFT = fftn(f2);%compute and visualize the DFT of f using fftn
f2_DFT = fftshift(f2_DFT); %balance
subplot(2,3,2), imshow(abs(f1_DFT),[]); %show the margin
subplot(2,3,3), imshow(angle(f1_DFT*180/pi)); %show the frequency
subplot(2,3,5), imshow(abs(f2_DFT), []);
subplot(2,3,6), imshow(angle(f2_DFT)*180/pi);
figure(3),
% Compute and visualize the 30-by-30 DFT of f
f3 = cos(2*pi*0.05*(cos(pi/3)*X+sin(pi/3)*Y)); 
subplot(2,3,1),imshow(f1,[]);
subplot(2,3,4),imshow(f3,[]);
f3_DFT = fftn(f3);%compute and visualize the DFT of f using fftn
f3_DFT = fftshift(f3_DFT);%balance
subplot(2,3,2), imshow(abs(f1_DFT),[]); %show the margin
subplot(2,3,3), imshow(angle(f1_DFT*180/pi)); %show the frequency
subplot(2,3,5), imshow(abs(f3_DFT), []);
subplot(2,3,6), imshow(angle(f3_DFT)*180/pi);
figure(4);
% Compute and visualize the 30-by-30 DFT of f
f3 = cos(2*pi*0.05*(cos(pi/3)*X+0.5)); 
subplot(2,3,1),imshow(f1,[]);
subplot(2,3,4),imshow(f3,[]);
f3_DFT = fftn(f3);%compute and visualize the DFT of f using fftn
f3_DFT = fftshift(f3_DFT);%balance
subplot(2,3,2), imshow(abs(f1_DFT),[]); %show the margin
subplot(2,3,3), imshow(angle(f1_DFT*180/pi)); %show the frequency
subplot(2,3,5), imshow(abs(f3_DFT), []);
subplot(2,3,6), imshow(angle(f3_DFT)*180/pi);
