I = imread('car.bmp');
[m,n,c] = size(I);
if c==3,
    I = rgb2gray(I); %promise changing to gray
end
%binary_image = Get_FrontGround(I); %get binary front image
binary_image = imread('without_front.bmp')/255;
front_image = uint8(I) .* uint8(1-binary_image);
background_image = uint8(I).* uint8(binary_image);
H_front = fspecial('motion',70,180);  %blur
MotionBlur_front = imfilter(front_image,H_front,'replicate');  %filtering
MotionBlur_front = MotionBlur_front + background_image;
figure(1),clf;
subplot(2,2,1),imshow(I),title('original image');
subplot(2,2,2),imshow(front_image),title('front background');
subplot(2,2,3),imshow(MotionBlur_front,[]),title('blurred front');
H_back = fspecial('motion',70,0); %blur, the opposite orientation
MotionBlur_back = imfilter(background_image, H_back, 'replicate');
MotionBlur_back = MotionBlur_back + front_image;
subplot(2,2,4), imshow(MotionBlur_back,[]),title('blurred background');
saveas(figure(1),'blur.jpg');
close all;

noise_mean = 0;
noise_var_list = [0.0001;0.001;0.01;0.1];
I = im2double(I);
for k = 1:4,
    noise_var = noise_var_list(k);
    blurred_noisy = imnoise(MotionBlur_front, 'gaussian',noise_mean, noise_var);%gaussian noise blur
    noisy = blurred_noisy - MotionBlur_front;%get pure noise
    deblur = deconvblind(blurred_noisy,noisy);%inverse filtering
    front_image = uint8(deblur) .* uint8(1-binary_image);
    background_image = uint8(deblur).* uint8(binary_image);
    front = deconvblind(front_image,H_front);%inverse filtering
    final_image = front + background_image;%final image
    figure(1),clf;
    subplot(2,2,1),imshow(I),title('original image');
    subplot(2,2,2),imshow(blurred_noisy),title('noisy');
    subplot(2,2,3),imshow(final_image),title('restoration by Inverse Filtering');
    estimated_nsr= noise_var/ var(I(:)); 
    front = deconvwnr(blurred_noisy,H_front, estimated_nsr);%winer filtering
    subplot(2,2,4),imshow(front),title('restoration by Wiener Filtering');
    saveas(figure(1),[num2str(k) 'front.jpg']);
    close all;
    figure(1),clf;
    blurred_noisy = imnoise(MotionBlur_back, 'gaussian',noise_mean, noise_var); %gaussian noise blur
    noisy = blurred_noisy - MotionBlur_back; %get pure noise
    deblur = deconvblind(blurred_noisy,noisy);%inverse filtering
    front_image = uint8(deblur) .* uint8(1-binary_image);
    background_image = uint8(deblur).* uint8(binary_image);
    back = deconvblind(background_image,H_back);%inverse filtering
    final_image = back + front_image;%final image
    figure(1),clf;
    subplot(2,2,1),imshow(I),title('original image');
    subplot(2,2,2),imshow(blurred_noisy),title('noisy');
    subplot(2,2,3),imshow(final_image),title('restoration by Inverse Filtering');
    front = deconvwnr(blurred_noisy,H_back, estimated_nsr); %winer filtering
    subplot(2,2,4),imshow(front),title('restoration by Wiener Filtering');
    saveas(figure(1),[num2str(k) 'back.jpg']);
    close all;
end