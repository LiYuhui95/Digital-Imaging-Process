I=imread('bull.jpg');
I = im2double(I);
J = rgb2hsv(I); %get hsi image
J1=J;
M = size(J,1);N = size(J,2);

threshold = 0.85; %the threshold for saturation
index = find(J(:,:,2)>threshold);
roi = false(size(J(:,:,2)));
roi(index) = 1;
J(:,:,2) = J(:,:,2)&roi;
figure(1), imshow(J(:,:,2)),title('S, after threshold');

figure(2),imshow(J(:,:,1)),title('picking point');
% choose point of interest
h = impoint;
pos = wait(h);
pos = round(pos);
a = J(pos(2),pos(1),1);

h = impoint;
pos = wait(h);
pos = round(pos);
b = J(pos(2),pos(1),1);

threshold = (b-a)*2/3+a; %the threshold for hue
index = find(J(:,:,1)>threshold);
roi = false(size(J(:,:,1)));
roi(index) = 1;
J(:,:,1) = J(:,:,1)&roi;
figure(3), imshow(J(:,:,1)),title('H after threshold');

X = J(:,:,1).*J(:,:,2); %image for choose
figure(4),imshow(X);

h = imrect; %square the position
pos = wait(h);
pos = round(pos);
roi = false(size(X));
roi(pos(2):pos(2)+pos(4),pos(1):pos(1)+pos(3)) = 1;
mask = X&roi; %get the mask

g = rgb2gray(I);%turning to gray
G = I;
G(:,:,1) = g;
G(:,:,2) = g;
G(:,:,3) = g;
index = find(mask); %get the mask
G(index) = I(index); %R
G(index+M*N) = I(index+M*N); %G
G(index+M*N*2) = I(index+M*N*2); %B

figure(5),imshow(G);

figure(6),clf; %show the HSI
subplot(1,3,1),imshow(J1(:,:,1),[]);
subplot(1,3,2),imshow(J1(:,:,2),[]);
subplot(1,3,3),imshow(J1(:,:,3),[]);

saveas(figure(1), 'S_threshold.jpg');
saveas(figure(3), 'H_threshold.jpg');
saveas(figure(4), 'process.jpg');
saveas(figure(5), 'final_bull.jpg');
saveas(figure(6), 'HSI_bull.jpg');