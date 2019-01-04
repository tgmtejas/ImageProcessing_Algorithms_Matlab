% Project 3 main file

% MATLAB PROGRAM TO PERFORM FILTERING ON IMAGES USING DISCRETE TIME 
% FOURIER TRANSFORMS

% TEAM MEMBERS:

% Sparsh Saxena, Tejas Mahale & Venkatakrishnan Iyer

% Input Variables:

%      f            input binary - 'checker.gif'
%      f_lake       input grayscale image - 'lake.gif'
%      x            x coordinate of a pixel
%      y            y coordinate of a pixel
%      u            uth frequency component of DFT
%      v            vth frequency component of DFT

% Output Variables:

% g1                output image after low pass filtering using Gaussian
%                   filter without zero padding and with DC component in
%                   the FT set to 0.
% g_lpf             filtered image using a low pass Gaussian filter without
%                   zero padding of size M x N
% g_pad             filtered image using a low pass Gaussian filter with
%                   zero padding of size P x Q
% g_pad_final       final image after extracting M x N relevan pixels of
%                   the gp image

% The project studies the concepts of performing Fourier Transform 
% operations on images and also anayses the effects of filtering images 
% using gaussian and notch filters.

% The Gaussian filter H used in this project has been taken directly from 
% Chapter 4 of 'Digital Image Processing using MATLAB' by Gonzalez, Woods,
% and Eddinsalso. 

%% Part 1A: Loading Checker Image

f = imread('checker.gif');
[M, N] = size(f);

% hFigure = imtool(uint8(f),[]);
% set(hFigure,'NumberTitle','off','Name','Checker image');

f = double(f);


%% FFT of Checker Image

F = fft2(f,M,N);
F_abs = abs(F);
F_grayscale = uint8(F_abs*255/max(max(F_abs)));
F_grayscale_scaled = log(1+F_abs);

% The fft has been normalized and scaled to the gray scale levels of 255 to
% provide better viewing characteristics in the output file.

% hFigure = imtool(abs(F),[]);
% set(hFigure,'NumberTitle','off','Name','FFT of Checker image');
% 
% hFigure = imtool(log(1+abs(F)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled FFT of Checker image');

imwrite(F_grayscale,'FFT of checker image.gif');
imwrite(uint8(F_grayscale_scaled*255/max(max(F_grayscale_scaled))),'Scaled FFT of checker image.gif');

%% Modulation of FFT of Checker Image

fm = double(zeros(M,N));

for x = 1:M
    for y = 1:N
        fm(x,y) = f(x,y)*((-1)^(x+y));
    end
end

Fm = fft2(fm,M,N);

% hFigure = imtool(abs(Fm),[]);
% set(hFigure,'NumberTitle','off','Name','Modulated FFT of Checker');
% 
% hFigure = imtool(log(1+abs(Fm)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled & Modulated FFT of Checker');

Fm_abs = abs(Fm);
Fm_grayscale = uint8(Fm_abs*255/max(max(Fm_abs)));
Fm_grayscale_scaled = log(1+Fm_abs);

imwrite(Fm_grayscale,'Modulated FFT - checker image.gif');
imwrite(uint8(Fm_grayscale_scaled*255/max(max(Fm_grayscale_scaled))),'Modulated Scaled FFT checker image.gif');

%% Setting DC component in FFT of checker image to 0

F1 = F;
F1(1,1) = 0;

g1 = double(real(ifft2(F1)));

g1_final = uint8(floor(g1*255));

% hFigure = imtool(uint8(g1_final));
% set(hFigure,'NumberTitle','off','Name','Checker image with 0 DC component');

imwrite(g1_final,'Image with No DC component.gif');

%% Part 1b: Low Pass Filtering

sig = 15;
H = lpfilter('gaussian', M, N, sig);
G_lpf = double(zeros(M,N));

for u = 1 : M
    for v = 1 : N
        G_lpf(u,v) = H(u,v)*F(u,v);
    end
end

% hFigure = imtool(abs(G_lpf),[]);
% set(hFigure,'NumberTitle','off','Name','FFT of Filtered image');

% hFigure = imtool(log(1+abs(G_lpf)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled FFT of Filtered image');

G_lpf_abs = abs(G_lpf);
G_lpf_grayscale = uint8(G_lpf_abs*255/max(max(G_lpf_abs)));
G_lpf_grayscale_scaled = log(1+G_lpf_abs);

imwrite(G_lpf_grayscale,'FFT of filtered image - no padding.gif');
imwrite(uint8(G_lpf_grayscale_scaled*255/max(max(G_lpf_grayscale_scaled))),'Scaled FFT of filtered image - no padding.gif');

g_lpf = real(ifft2(G_lpf));

imwrite(uint8(g_lpf*255),'Filtered image without padding.gif');

% hFigure = imtool(g_lpf);
% set(hFigure,'NumberTitle','off','Name','Low pass filtered image');

%% Plotting FFT of Gaussian Filter

H_abs = abs(H);
H_grayscale = uint8(H_abs*255/max(max(H_abs)));
H_grayscale_scaled = log(1+H_abs);

imwrite(H_grayscale,'FFT of Gaussian Filter.gif');
imwrite(uint8(H_grayscale_scaled*255/max(max(H_grayscale_scaled))),'Scaled FFT of gaussian fliter.gif');

% hFigure = imtool(abs(H),[]);
% set(hFigure,'NumberTitle','off','Name','FFT of Gaussian Filter');
% 
% hFigure = imtool(log(1+abs(H)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled FFT of Gaussian Filter');

%Make 3D plot of H(u,v)
% figure('Name','Mesh plot of Gaussian Filter','NumberTitle','off');

figure;
corner_fft = mesh(H(1:5:256, 1:5:256));
saveas(corner_fft, '3D figure of filter.png');

%Shifting H(u,v) to the centre
Hm = fftshift(H);

Hm_abs = abs(Hm);
Hm_grayscale = uint8(Hm_abs*255/max(max(Hm_abs)));
Hm_grayscale_scaled = log(1+Hm_abs);

imwrite(Hm_grayscale,'Modulated FFT of Gaussian Filter.gif');
imwrite(uint8(Hm_grayscale_scaled*255/max(max(Hm_grayscale_scaled))),'Modulated Scaled FFT of gaussian fliter.gif');

% figure('Name','Mesh plot of shifted Gaussian Filter','NumberTitle','off');
figure;
center_fft =mesh(Hm(1:5:256, 1:5:256));
saveas(center_fft, '3D centered figure of filter.png');

%% Shifting FFT of g(x,y)

g_lpf_m = double(zeros(M,N));

for x = 1:M
    for y = 1:N
        g_lpf_m(x,y) = g_lpf(x,y)*((-1)^(x+y));
    end
end

G_lpf_m = fft2(g_lpf_m, M, N);

% hFigure = imtool(abs(G_lpf_m),[]);
% set(hFigure,'NumberTitle','off','Name','Modulated FFT of filtered image');
% 
% hFigure = imtool(log(1 + abs(G_lpf_m)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled, Modulated FFT of filtered image');

G_lpf_m_abs = abs(G_lpf_m);
G_lpf_m_grayscale = uint8(G_lpf_m_abs*255/max(max(G_lpf_m_abs)));
G_lpf_m_grayscale_scaled = log(1+G_lpf_m_abs);

imwrite(G_lpf_m_grayscale,'Modulated FFT of filtered image.gif');
imwrite(uint8(G_lpf_m_grayscale_scaled*255/max(max(G_lpf_m_grayscale_scaled))),'Modulated Scaled FFT of filtered image.gif');


%% Part 1c: Zero Padded filtering

P = 2*M;
Q = 2*N;

F_pad = fft2(f,P,Q);
H_pad = lpfilter('gaussian', P, Q, sig);
G_pad = double(zeros(P,Q));

for u = 1 : P
    for v = 1 : Q
        G_pad(u,v) = H_pad(u,v)*F_pad(u,v);
    end
end

g_pad = real(ifft2(G_pad));
g_pad_final = g_pad(1:M,1:N);

% hFigure = imtool(g_pad_final);
% set(hFigure,'NumberTitle','off','Name','Filtered image after zero pad');
% 
% hFigure = imtool(abs(G_pad),[]);
% set(hFigure,'NumberTitle','off','Name','FFT of 0 pad filtered image');
% 
% hFigure = imtool(log(1+abs(G_pad)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled FFT of 0 pad filtered image');

imwrite(uint8(g_pad*255),'Filtered image with zero padding.gif');
imwrite(uint8(g_pad_final*255),'Cropped filtered image with zero padding.gif');

G_pad_abs = abs(G_pad);
G_pad_grayscale = uint8(G_pad_abs*255/max(max(G_pad_abs)));
G_pad_grayscale_scaled = log(1+G_pad_abs);

imwrite(G_pad_grayscale,'FFT of zero pad filtered image.gif');
imwrite(uint8(G_pad_grayscale_scaled*255/max(max(G_pad_grayscale_scaled))),'Scaled FFT of zero pad filtered image.gif');


%% FFT plots of P x Q Gaussian Filter

H_pad_abs = abs(H_pad);
H_pad_grayscale = uint8(H_pad_abs*255/max(max(H_pad_abs)));
H_pad_grayscale_scaled = log(1+H_pad_abs);

imwrite(H_pad_grayscale,'FFT of zero pad Gaussian Filter.gif');
imwrite(uint8(H_pad_grayscale_scaled*255/max(max(H_pad_grayscale_scaled))),'Scaled FFT of zero pad gaussian fliter.gif');

% Plot Scaled version of |Hp(u,v)|
% hFigure = imtool(abs(H_pad),[]);
% set(hFigure,'NumberTitle','off','Name','FFT of P x Q Gaussian Filter');
% 
% hFigure = imtool(log(1+abs(H_pad)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled FFT of P x Q Gaussian Filter');

% Make 3D plot of H(u,v)
% figure('Name','Mesh FFT of P x Q Gaussian Filter','NumberTitle','off');
% mesh(real(H_pad(1:5:512, 1:5:512)));

figure;
zero_pad_fft = mesh(H_pad(1:5:512, 1:5:512));
saveas(zero_pad_fft, '3D figure of zero pad filter.png');
%% Modulation of zero padded g(x,y)

g_pad_m = double(zeros(P,Q));

for x = 1:P
    for y = 1:Q
        g_pad_m(x,y) = g_pad(x,y)*((-1)^(x+y));
    end
end

G_pad_m = fft2(g_pad_m, P, Q);

% hFigure = imtool(abs(G_pad_m),[]);
% set(hFigure,'NumberTitle','off','Name','Modulated FFT of 0 pad filtered image');
% 
% hFigure = imtool(log(1+abs(G_pad_m)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled, Modulated FFT of 0 pad filtered image');

G_pad_m_abs = abs(G_pad_m);
G_pad_m_grayscale = uint8(G_pad_m_abs*255/max(max(G_pad_m_abs)));
G_pad_m_grayscale_scaled = log(1+G_pad_m_abs);

imwrite(G_pad_m_grayscale,'Modulated FFT of zero pad filtered image.gif');
imwrite(uint8(G_pad_m_grayscale_scaled*255/max(max(G_pad_m_grayscale_scaled))),'Modulated Scaled FFT of zero pad filtered image.gif');
