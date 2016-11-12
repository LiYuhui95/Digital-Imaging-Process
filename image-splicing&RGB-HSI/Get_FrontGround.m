function [ binary_image ] = Get_FrontGround( image )
    close all;
    imshow(image);
    [x,y] = ginput;
    binary_image = roipoly(image,x,y);
    imwrite(binary_image,'binary.bmp');
    binary_image = 1 - binary_image;
    imwrite(binary_image,'without_front.bmp');
end

