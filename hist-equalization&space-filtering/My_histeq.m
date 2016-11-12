function [  ] = My_histeq( root )
    %root = 'F:\digital_image\HW2\'
    Files = dir(strcat(root ,'*.tif'));
    LengthFile = length(Files);
    for loop = 1:LengthFile,
        image = imread(Files(loop).name); %read image
        [m,n,value] = size(image); %get size
        if (value==3),
            image = rgb2gray(image); %change to gray
        end
        Pixel_Count = zeros(1, 256); %save the pixel value and count, note 1:256 in range, but 0:255 in pixel values
        for i = 1:m,
            for j = 1:n,
                Pixel_Count(image(i,j)+1) = Pixel_Count(image(i,j)+1) + 1;
            end
        end
        Hist_eq = zeros(1, 256); %save the histogram
        for i = 1: 256,
            if i == 1,
                Hist_eq(i) =  Pixel_Count(i);
            else
                Hist_eq(i) = Pixel_Count(i) + Hist_eq(i-1); %probability
            end
        end
        Hist_eq = uint8(Hist_eq * 255 / (m*n) +0.5); %get inteager and take the floor()
        image_C = image; %save the final image after histeq
        for i = 1:m,
            for j = 1:n,
                image_C(i,j) = Hist_eq(image(i,j)+1);
            end
        end
        imwrite(image_C,['hist_eq_',Files(loop).name]);
    end       
end
