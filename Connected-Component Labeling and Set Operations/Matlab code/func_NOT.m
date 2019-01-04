function image_not = func_NOT(match1)

% This function is used to perform NOT operation on image 'match1.gif' 

A = match1;

image_not = zeros(256);

for i = 1: 256
    for j = 1:256
        if A(i,j) == 1
            image_not(i,j) = 0;
        else
            image_not(i,j) = 255;      % A is a binary image. 
        end                            % Converted to 8 bit grayscale
    end
end

image_not = uint8(image_not);

imwrite(image_not,'NOT_image.gif');

end