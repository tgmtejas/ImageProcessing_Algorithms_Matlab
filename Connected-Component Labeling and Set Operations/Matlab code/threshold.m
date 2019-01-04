function fthresh = threshold(f1)

% This function is used to determine the threshold value to determine the 
% brightest components. 

fthresh = zeros(256);

for i = 1:256
    for j = 1:256
        if f1(i,j) >= 145            % In case the threshold is >= 145
            fthresh(i,j) = f1(i,j);  % the value from the image is being
        else                         % retained. All values below the
            fthresh(i,j) = 0;        % threshold are set to 0.
        end
    end
end

fthresh = uint8(fthresh);

imwrite(fthresh,'threshold_image.gif');

end