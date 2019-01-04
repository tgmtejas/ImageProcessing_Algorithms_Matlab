function E = func_MIN(image1,image2)

% This function is used to determine the minimum pixel intensity values 
% between images 'mandril_gray.tif' and 'cameraman.tif'

C = image1;
D = image2;

E = zeros(512);

for i = 1: 512
    for j = 1:512
        if C(i,j) <= D(i,j)
            E(i,j) = C(i,j);
        else
            E(i,j) = D(i,j);
        end
    end
end

E = uint8(E);

imwrite(E,'MIN_image.gif');

end