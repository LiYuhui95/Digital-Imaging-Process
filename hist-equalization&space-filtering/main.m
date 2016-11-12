messi_image = imread('messi.bmp'); %read image
[m,n,c] = size(messi_image);
if c==3,
    messi_image = rgb2grey(messi_image);
end
binary_image = Get_FrontGround(messi_image); %get binary front image
%binary_image = imread('without_front.bmp')/255;
front_image = uint8(messi_image) .* uint8(1-binary_image);
image_process = uint8(messi_image) .* uint8(binary_image); %get image to process
Filter_Range = [6, 20, 30, 50];
for i = 1:4,
    filter_size = Filter_Range(i);%filter size 6*6, 20*20, 30*30, 50*50
    median_image = medfilt2(image_process,[filter_size,filter_size]); %median filter
    imwrite(median_image+front_image,['median',num2str(i),'.bmp']);
    linear_image = filter2(fspecial('average',filter_size),image_process)/255; %linear filter
    imwrite(linear_image+double(front_image)/255,['linear',num2str(i),'.bmp']);
    filter_size = 3*i; % filter size is 3, 6, 9, 12
    mean_image = imfilter(image_process,i);%mean filter
    imwrite(mean_image+front_image,['mean',num2str(i),'.bmp']);
end

  
