function [ final_image ] = Median_Filter( image, filter_size )
    [height, width] = size(image);
    image = double(image);
    final_image = image;
    for i = 1:height - filter_size + 1,
        for j = 1:width - filter_size + 1,
            square = image(i:(i + filter_size - 1), j:(j + filter_size - 1));
            median_square = median(median(square)); %use median value to replace image
            final_image(i + filter_size - 1, j + filter_size -1) = median_square;
        end
    end
    final_image = uint8(final_image);
end

