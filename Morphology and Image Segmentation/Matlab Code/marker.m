function marker_image = marker(f)

% This function is used to obtain the marker image that identifies the
% location of the tall characters

[M, N] = size(f);

marker_image = uint8(255*ones(M));

% As the tall charcaters are 45 pixels in height, a mask of 45x1 is used to
% locate the tall charcaters. 

% The following FOR loop is an erosion operation. If the charcaters are not
% 45 pixels in height, then the mask is not a subset of the charcater and
% outputs a zero. 

for x = 23:M-23
    for y = 1:N
        if max(f(x-22:x+22,y)) == 0
            marker_image(x,y) = f(x,y);
        else
            marker_image(x,y) = 255;
        end
    end
end
end