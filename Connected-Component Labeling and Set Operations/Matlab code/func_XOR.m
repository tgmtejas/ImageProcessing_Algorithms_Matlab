function image_xor = func_XOR(match1,match2)

% This function is used to perform XOR operation on images 'match1.gif' and
% 'match2.gif'

A = match1;
B = match2;

image_xor = zeros(256);

for i = 1: 256
    for j = 1:256
        if A(i,j) == B(i,j)
            image_xor(i,j) = 0;
        else
            image_xor(i,j) = 255;      % A & B are binary images.
        end                            % Converted to 8 bit grayscale
    end
end

image_xor = uint8(image_xor);

imwrite(image_xor,'XOR_image.gif');

end