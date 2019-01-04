% Project 2 main file

% MATLAB PROGRAM TO DETERMINE THE CONNECTED COMPONENTS IN AN IMAGE  
% AND STUDY THE EFFECT OF SET OOPERATIIONS ON IMAGES

% TEAM MEMBERS:

% Sparsh Saxena, Tejas Mahale & Venkatakrishnan Iyer

% Input Variables:

%      f1       input grayscale image - 'wheelnoise.gif'
%      f2       input binary image - 'match1.gif'
%      f3       input binary image - 'match2.gif'
%      f4       input grayscale image - 'mandril_gray.tif'
%      f5       input grayscale image - 'cameraman.tif'
%      i        x coordinate of a pixel
%      j        y coordinate of a pixel

% Output Variables:

% fthresh             output image with gray values above threshold
% fbin                binary image generated out of fthresh
% flabel              consists of all labeled connected components
% fRGB                RGB image showing all connected components
% num_of_elements     Lists the component nos along with count
% sorted_array        num_of_elements sorted in ascending order based on
%                     pixel count of each connected component
% largest_4           array of the labels of the largest 4 components
% final_4             image displaying only the largest 4 components
% image_and           output image of A ('match1.gif') AND B ('match2.gif')
% image_or            output image of A ('match1.gif') OR B ('match2.gif')
% image_xor           output image of A ('match1.gif') XOR B ('match2.gif')
% image_not           output image of negation of A ('match1.gif')
% E                   output image of minimum of C ('mandril_gray') and 
%                     D ('cameraman.tif')


% The project studies the concepts of connected components in an image and 
% determines the connected components in an image using 8 connectivity. 
% The program is used to determine the four largest connected components of
% an image.

% The project also explores the effect of set operations on images. Various
% operations such as AND, OR, XOR and NOT are performed and the resultant 
% images are studied. Also, the effect of using a minimum operator on two
% images is studied.


% Part 1: Finding the largest 4 components in the image wheelnoise.gif

f1 = imread('wheelnoise.gif');
imtool(f1);

fthresh = threshold(f1); % generates the threshold image

[fRGB, flabel, num] = label_comp(fthresh); % generates RGB image of all 
                                           % connected components

imshow(fthresh);
figure;
imshow(fRGB);

final_4 = largest_4(flabel, num, f1); % generates the final output image  
                                      % with the largest 4 components.

figure;
imshow(final_4);


% Part 2: Set operations on images

f2 = imread('match1.gif');
f3 = imread('match2.gif');
f4 = imread('mandril_gray.tif');
f5 = imread('cameraman.tif');

image_and = func_AND(f2,f3);   % generates image after AND operation

image_or = func_OR(f2,f3);     % generates image after OR operation

image_xor = func_XOR(f2,f3);   % generates image after XOR operation

image_not = func_NOT(f2);      % generates image after NOT operation

E = func_MIN(f4,f5);           % generates image after MIN operation


% end of main program