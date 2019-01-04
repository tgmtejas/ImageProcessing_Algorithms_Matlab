function image_and = func_AND(match1,match2)

% This function is used to perform AND operation on images 'match1.gif' and
% 'match2.gif'

A = match1;
B = match2;

image_and = zeros(256);

for i = 1: 256
    for j = 1:256
        if A(i,j) == 1 && B(i,j) == 1
            image_and(i,j) = 255;      % A & B are binary images. 
        else                           % Converted to 8 bit grayscale
            image_and(i,j) = 0;
        end
    end
end

image_and = uint8(image_and); 

imwrite(image_and,'AND_image.gif');

end