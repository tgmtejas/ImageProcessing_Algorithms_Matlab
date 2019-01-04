function image_or = func_OR(match1,match2)

% This function is used to perform OR operation on images 'match1.gif' and
% 'match2.gif'

A = match1;
B = match2;

image_or = zeros(256);

for i = 1: 256
    for j = 1:256
        if A(i,j) == 1 || B(i,j) == 1
            image_or(i,j) = 255;        % A & B are binary images.
        else                            % Converted to 8 bit grayscale
            image_or(i,j) = 0;
        end
    end
end

image_or = uint8(image_or);

imwrite(image_or,'OR_image.gif');

end