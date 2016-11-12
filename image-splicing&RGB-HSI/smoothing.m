messi_image = imread('messi.jpg'); %read image
[m,n,c] = size(messi_image);
%binary_image = Get_FrontGround(messi_image); %get binary front image
for k = 1:3,
    binary_image(:,:,k) = imread('without_front.bmp')/255;
end
front = uint8(messi_image).* uint8((1-binary_image)); %get front
back = uint8(messi_image).* uint8(binary_image); %get back

hsize_list = [20,40,60,80,100];
for k = 1:5,
    hsize = hsize_list(k);% size of averaging filter
    h = ones(hsize,hsize)/(hsize*hsize); %filter

    J = im2double(back);
    J_hsv = rgb2hsv(J); %get hsv image
    J2_hsv = J_hsv;
    J2_hsv(:,:,3) = imfilter(J_hsv(:,:,3),h); %smooth intensity of HSI
    J2 = hsv2rgb(J2_hsv);

    J1 = im2double(messi_image); %initilize
    for i = 1:3
        J1(:,:,i) = imfilter(J(:,:,i),h); %smooth RGB channel
    end

    figure(1),clf;
    J1 = im2double(front)+J1;
    J2 = im2double(front)+J2;
    subplot(2,2,1),imshow(messi_image,[]),title('original image');
    subplot(2,2,2),imshow(J1,[]),title('smooth RGB channels');
    subplot(2,2,3),imshow(J2,[]);title('smooth intensity of HSI only')
    saveas(figure(1), [num2str(k) '.jpg']);
    close all;
end