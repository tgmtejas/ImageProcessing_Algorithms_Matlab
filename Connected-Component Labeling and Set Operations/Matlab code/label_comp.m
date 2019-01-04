function [fRGB, flabel, num] = label_comp(fthresh)

% This function is used to determine the array of labeled components in 
% the 'wheelnoise.gif' image.


fbin = logical(fthresh);          % The 'bwlabel' operator works on binary
                                  % images. Hence, the 8 bit grayscale is 
                                  % converted to binary array using the 
                                  % 'logical' operator 

[flabel, num] = bwlabel(fbin, 8); % 'flabel' stores the labeled components
                                  % 'num' stores the number of labeled 
                                  % components 

                                  % '8' specifies that 8 connectivity is 
                                  % used to determine the components
                                  
fRGB = label2rgb(flabel);         % the flabel array is converted to an 
                                  % RGB image so that different components 
                                  % can be differentiated through colour

imwrite(fRGB,'RGB_image.png');

end