function [f_reconstruct, count] = reconstruct(f_clean, f_marker)

% This function is used to reconstruct the tall letters from the marker 
% image

[M, N] = size(f_clean);
f_reconstruct = uint8(f_marker);
f_inter = uint8(255*ones(409));
i = 1;
count = 0;

% The variable 'i' is used to only initialize thw WHILE loop.

% In the WHILE loop, repeated dilation is performed followed by determining
% the intersection between the dilated image and the clean image.

% The iteration is repeated until there is no difference between the
% current iteration and the previous iteration.

while i == 1
    fd = dilation(f_reconstruct);
    for x = 1:M
        for y = 1:N
            if fd(x,y) == 0 && f_clean(x,y) == 0
                f_inter(x,y) = 0;
            else
                f_inter(x,y) = 255;
            end
        end
    end
    if max(max(f_reconstruct - f_inter)) == 0
        break;
    else
        f_reconstruct = f_inter;
        count = count + 1;
    end
end

end
