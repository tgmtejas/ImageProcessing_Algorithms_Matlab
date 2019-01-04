% Project 4 main file

% MATLAB PROGRAM TO PERFORM IMAGE ENHANCEMENT THROUGH HISTOGRAM 
% MODIFICATIONS 

% TEAM MEMBERS:

% Sparsh Saxena, Tejas Mahale & Venkatakrishnan Iyer

% Input Variables:

%      f            input binary - 'checker.gif'
%      x            x coordinate of a pixel
%      y            y coordinate of a pixel


% Output Variables:

% f1                Output image with gamma correction 0.2
% f2                Output image with gamma correction 5
% f3                Output image with lower 10% and higher 90% intensities
%                   set to 0
% f4                Output image after contrast stretching
% f5                Output image after Histogram Equalization


% The project studies the concepts of performing image enhancement through 
% techniques such as gamma corrections and Histogram Equalization. 

%% 1. Generation of PDF and CDF of Original Image

clc;
clear all;
close all;
warning off;

f = imread('truck.gif');

[x,y] = size(f);

[hist_original, cum_original, pdf_original, cdf_original]= distribution(f, x, y);

hist_plot= bar(hist_original);
xlabel('Pixel intensity');
ylabel('P^r(r)')
title( 'Histogram of original image')
saveas(hist_plot, 'Histogram of original image.png')


cum_plot = bar(cum_original); 
xlabel ('Pixel intensity');
ylabel ('C^r(r)')
title ( 'Cumulative Distribution of original image')
saveas (cum_plot, 'Cumulative Distribution of original image.png')

pdf_plot= bar(pdf_original);
xlabel('Pixel intensity');
ylabel('Pr(r)')
title( 'PDF of original image')
saveas(pdf_plot, 'PDF of original image.png')


cdf_plot = bar(cdf_original); 
xlabel ('Pixel intensity');
ylabel ('Cr(r)')
title ( 'CDF of original image')
saveas (cdf_plot, 'CDF of original image.png')

%% 2. Gamma Correction

f1= double(zeros(x,y));
f2= double(zeros(x,y));
f=double(f);

for i = 1:x
      for j = 1:y
          
          f1(i,j)= uint8(255*((f(i,j)/255)^0.2));
          f2(i,j)= uint8(255*((f(i,j)/255)^5));
          
      end
end

%Plot of CDF and PDF of f1 :-

[hist_f1, cum_f1, pdf_f1, cdf_f1]= distribution(f1, x ,y);

hist_plot= bar(hist_f1);
xlabel('Pixel intensity');
ylabel('P^r(r)')
title( 'Histogram of Gamma (0.2) image')
saveas(hist_plot, 'Histogram of gamma_0_2 image.png');


cum_plot = bar(cum_f1); 
xlabel ('Pixel intensity');
ylabel ('C^r(r)')
title ( 'Cumulative Distribution of Gamma (0.2) image')
saveas (cum_plot, 'Cumulative Distribution of gamma_0_2 image.png');

pdf_plot= bar(pdf_f1);
xlabel('Pixel intensity');
ylabel('Pr(r)')
title( 'PDF of Gamma (0.2) image')
saveas(pdf_plot, 'PDF of gamma_0_2 image.png')

cdf_plot = bar(cdf_f1); 
xlabel ('Pixel intensity');
ylabel ('Cr(r)')
title ( 'CDF of Gamma (0.2) image')
saveas (cdf_plot, 'CDF of gamma_0_2 image.png')


%Plot of CDF and PDF of f2 :-

[hist_f2, cum_f2, pdf_f2, cdf_f2]= distribution(f2, x ,y);

hist_plot= bar(hist_f2);
xlabel('Pixel intensity');
ylabel('P^r(r)')
title( 'Histogram of Gamma (5) image')
saveas(hist_plot, 'Histogram of gamma_5 image.png')


cum_plot = bar(cum_f2); 
xlabel ('Pixel intensity');
ylabel ('C^r(r)')
title ( 'Cumulative Distribution of Gamma (5) image')
saveas (cum_plot, 'Cumulative Distribution of gamma_5 image.png')

pdf_plot= bar(pdf_f2);
xlabel('Pixel intensity');
ylabel('Pr(r)')
title( 'PDF of Gamma (5) image')
saveas(pdf_plot, 'PDF of gamma_5 image.png')

cdf_plot = bar(cdf_f2); 
xlabel ('Pixel intensity');
ylabel ('Cr(r)')
title ( 'CDF of Gamma (5) image')
saveas (cdf_plot, 'CDF of gamma_5 image.png')


%Saving gamma corrected images with factor 0.2 and 5
imwrite(f1, 'Gamma corrected image with factor 0_2.gif');
imwrite(f2, 'Gamma corrected image with factor 5.gif');

%% 3. Contrast Stretching 

for i=1:1: x
    if cum_original(1,i) >= 0.1* x *y
       min_10 = i-2;
       break;
    end
end

for i=1:1: x
    
    if cum_original(1,i) >= 0.9* x *y
        max_90 = i-2;
        break;
    end
end


f3= double(zeros(x,y));
for i = 1:x
      for j = 1:y
          
          if f(i,j)<= min_10
              
              f3(i,j)= 0;
                                    
          elseif f(i,j)>= max_90
              
              f3(i,j)= 255;
              
          else
              
              f3(i,j)=f(i,j);
          end

      end
end

f3 = uint8(f3);
imwrite(f3, 'Intermediate image before stretching.gif');       


f4= double(zeros(x,y));
for i = 1:x
    for j = 1:y
          if f(i,j)<= min_10
              
              f4(i,j)= 0;
                                    
          elseif f(i,j)>= max_90
              
              f4 (i,j)= 255;
              
          else
              
              f4(i,j)=255*((f(i,j)-min_10)/(max_90-min_10));
          end

    end
end

f4 = uint8(f4);

%Saving Linearly stretched image
% figure;
% imshow(uint8(f4));
imwrite(f4, 'Linearly stretched image.gif');

%PDF and CDF of Linearly stretched image

[hist_f4, cum_f4, pdf_f4, cdf_f4]= distribution(f4, x ,y);

hist_plot= bar(hist_f4);
xlabel('Pixel intensity');
ylabel('P^r(r)')
title( 'Histogram of contrast stretched image')
saveas(hist_plot, 'Histogram of contrast stretched image.png')


cum_plot = bar(cum_f4); 
xlabel ('Pixel intensity');
ylabel ('C^r(r)')
title ( 'Cumulative Distribution of contrast stretched image')
saveas (cum_plot, 'Cumulative Distribution of contrast stretched image.png')

pdf_plot= bar(pdf_f4);
xlabel('Pixel intensity');
ylabel('Pr(r)')
title( 'PDF of contrast stretched image')
saveas(pdf_plot, 'PDF of contrast stretched image.png')

cdf_plot = bar(cdf_f4); 
xlabel ('Pixel intensity');
ylabel ('Cr(r)')
title ( 'CDF of contrast stretched image')
saveas (cdf_plot, 'CDF of contrast stretched image.png')


%% 4. Histogram Equalization

f5=double(zeros(x,y));

for i=1 : x
    for j = 1 : y
        
      f5(i, j) = uint8(255*cdf_original(1,f(i,j)+1)); 
        
    end
end
        
imwrite(f5, 'Histogram Equalized image.gif');


%PDF and CDF of HE image

[hist_f5, cum_f5, pdf_f5, cdf_f5]= distribution(f5, x ,y);

hist_plot= bar(hist_f5);
xlabel('Pixel intensity');
ylabel('P^r(r)')
title( 'Histogram of HE image')
saveas(hist_plot, 'Histogram of HE image.png')


cum_plot = bar(cum_f5); 
xlabel ('Pixel intensity');
ylabel ('C^r(r)')
title ( 'Cumulative Distribution of HE image')
saveas (cum_plot, 'Cumulative Distribution of HE image.png')

pdf_plot= bar(pdf_f5);
xlabel('Pixel intensity');
ylabel('Pr(r)')
title( 'PDF of HE image')
saveas(pdf_plot, 'PDF of HE image.png')

cdf_plot = bar(cdf_f5); 
xlabel ('Pixel intensity');
ylabel ('Cr(r)')
title ( 'CDF of HE image')
saveas (cdf_plot, 'CDF of HE image.png')