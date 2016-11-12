close all, clear all
initial_image = zeros(256,256);
%create some binary rectangles
[x,y] = meshgrid(100:200);
f1 = initial_image; %zero image
f1(x,y) = 1; %construct rectangle
f1_DFT = fftn(f1);%dft using fftn
f1_DFT = fftshift(f1_DFT);%balance
figure(1);
subplot(2,3,1),imshow(f1,[]);
subplot(2,3,2), imshow(abs(f1_DFT),[]); %show the margin
subplot(2,3,3), imshow(angle(f1_DFT*180/pi)); %show the frequency

[x,y] = meshgrid(50:250);
f2 = initial_image;
f2(x,y) = 1;%constrct rectangle of different size
f2_DFT = fftn(f2);%dft using fftn
f2_DFT = fftshift(f2_DFT);%balance
subplot(2,3,4),imshow(f2,[]);
subplot(2,3,5), imshow(abs(f2_DFT),[]); %show the margin
subplot(2,3,6), imshow(angle(f2_DFT*180/pi)); %show the frequency

x=meshgrid(25:125);
y=meshgrid(20:120);
f2 = initial_image;
f2(x,y) = 1;
figure(2);
subplot(2,3,1),imshow(f1,[]);
subplot(2,3,2), imshow(abs(f1_DFT),[]); %show the margin
subplot(2,3,3), imshow(angle(f1_DFT*180/pi)); %show the frequency
f2_DFT = fftn(f2);
f2_DFT = fftshift(f2_DFT);
subplot(2,3,4),imshow(f2,[]);
subplot(2,3,5), imshow(abs(f2_DFT),[]); %show the margin
subplot(2,3,6), imshow(angle(f2_DFT*180/pi)); %show the frequency

f2 = imrotate(f1,45,'bilinear'); %rotate
figure(3);
subplot(2,3,1),imshow(f1,[]);
subplot(2,3,2), imshow(abs(f1_DFT),[]); %show the margin
subplot(2,3,3), imshow(angle(f1_DFT*180/pi)); %show the frequency
f2_DFT = fftn(f2);
f2_DFT = fftshift(f2_DFT);
subplot(2,3,4),imshow(f2,[]);
subplot(2,3,5), imshow(abs(f2_DFT),[]); %show the margin
subplot(2,3,6), imshow(angle(f2_DFT*180/pi)); %show the frequency