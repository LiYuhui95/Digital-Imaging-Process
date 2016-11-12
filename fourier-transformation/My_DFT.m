function [ DFT_output ] = My_DFT( N )
    [x, y] = meshgrid(0:(N-1), 0:(N-1));
    DFT_output = exp(-2j * pi * (x.*y) / N);
end

