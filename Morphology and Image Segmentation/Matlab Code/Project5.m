% Project 5 main file

% MATLAB PROGRAM TO PERFORM MORPHOLOGICAL OPERATIONS ON IMAGES AND IMAGE  
% RECONSTRUCTION

% TEAM MEMBERS:

% Sparsh Saxena, Tejas Mahale & Venkatakrishnan Iyer

% Input Variables:

%      f            noisy input image
%      x            x coordinate of a pixel
%      y            y coordinate of a pixel

% Output Variables:

% ft                Threshold image
% f_clean           Clean image after noise eliminatiion 
% f_marker          Marker image which identifies the tall letters
% f_reconstruct     Reconstructed image with tall letters
% f_edge            recostructed image with only outline of tall characters


% This project studies the effect of morphological operations on images and
% the use of the same to extract relevant informatiion from the images.

% Morphological operations such as image reconstruction and edge detection
% have been explored in this project.

%% Part 1A: Loading Checker Image

f = imread('proj5.gif');
[M, N] = size(f);

figure('NumberTitle','off', 'Name', 'Noisy Input Image');
imshow(f);
%% Thresholding of image to convert to binary

% As the input image is not in binary form, the image is first converted
% to binary form to facilitate morphological operations.


ft = uint8(zeros(M));

for x = 1:M
    for y = 1:N
        if f(x,y) < 75
            ft(x,y) = 0;
        else
            ft(x,y) = 255;
        end
    end
end

figure('NumberTitle','off', 'Name', 'Threshold Image');
imshow(ft);
imwrite(ft,'Threshold image.gif');

%% Operation for elimination of noise

% To eliminate the noise, open followed by a closing opeartion is performed
% on the image

f_open = uint8(dilation(erosion(ft)));
f_clean = uint8(erosion(dilation(f_open)));

figure('NumberTitle','off', 'Name', 'Image after Open operation');
imshow(f_open);
imwrite(f_open,'Image after Open operation.gif');

figure('NumberTitle','off', 'Name', 'Clean Image without noise');
imshow(f_clean);
imwrite(f_clean,'Clean image without noise.gif');

%% Marker Image

% This section outputs a marker image that marks the position of the tall
% characters in the image.

f_marker = uint8(marker(f_clean));

figure('NumberTitle','off', 'Name', 'Marker image');
imshow(f_marker);
imwrite(f_marker,'Marker image.gif');

%% Reconstruction

% After obtaining the marker image, repeated conditional dilation is
% performed to reconstruct the tall letters from the marker image

[f_reconstruct, count] = reconstruct(f_clean, f_marker);

figure('NumberTitle','off', 'Name', 'Reconstructed image');
imshow(f_reconstruct);
imwrite(f_reconstruct,'Reconstructed image with tall letters.gif');

%% Edge Detection

% This section outputs the outline of the tall letters that were detected.

f_dilate = uint8(dilation(f_reconstruct));
f_erode = uint8(erosion(f_reconstruct));

f_edge = 255 - f_erode + f_dilate;

figure('NumberTitle','off', 'Name', 'Edge image');
imshow(f_edge);
imwrite(f_edge,'Edge image.gif');
