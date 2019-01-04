%% Loading 'Lake' image:

f_lake = imread('lake.tif');
f_lake = double(f_lake(:,:,1));

f1_lake = uint8(f_lake);
% hFigure = imtool(f1_lake);
% set(hFigure,'NumberTitle','off','Name','Lake image');

[M1, N1] = size(f_lake);

%% Plotting FFT of 'Lake' image:

F_lake = fft2(f_lake, M1, N1);

% hFigure = imtool(abs(F_lake),[]);
% set(hFigure,'NumberTitle','off','Name','FFT of Lake');
% 
% hFigure = imtool(log(1 + abs(F_lake)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled FFT of Lake');

F_lake_abs = abs(F_lake);
F_lake_grayscale = uint8(F_lake_abs*255/max(max(F_lake_abs)));
F_lake_grayscale_scaled = log(1+F_lake_abs);

imwrite(F_lake_grayscale,'FFT of Lake image.gif');
imwrite(uint8(F_lake_grayscale_scaled*255/max(max(F_lake_grayscale_scaled))),'Scaled FFT of Lake image.gif');

%% Plotting shifted FFT of 'Lake' image:

fm_lake = double(zeros(M1,N1));

for x = 1:M1
    for y = 1:N1
        fm_lake(x,y) = f_lake(x,y)*((-1)^(x+y));
    end
end

Fm_lake = fft2(fm_lake, M1, N1);

% hFigure = imtool(abs(Fm_lake),[]);
% set(hFigure,'NumberTitle','off','Name','Modulated FFT of Lake');
% 
% hFigure = imtool(log(1 + abs(Fm_lake)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled & Modulated FFT of Lake');

Fm_lake_abs = abs(Fm_lake);
Fm_lake_grayscale = uint8(Fm_lake_abs*255/max(max(Fm_lake_abs)));
Fm_lake_grayscale_scaled = log(1+Fm_lake_abs);

imwrite(Fm_lake_grayscale,'Modulated FFT of Lake.gif');
imwrite(uint8(Fm_lake_grayscale_scaled*255/max(max(Fm_lake_grayscale_scaled))),'Modulated Scaled FFT of lake.gif');

%% Corrupting 'Lake' image with noise:

c = double(zeros(M1,N1));

for x = 1:M1
    for y = 1:N1
        c(x,y) = f_lake(x,y) + 32*cos(2*pi*32*x/M1);
    end
end

% hFigure = imtool(uint8(c));
% set(hFigure,'NumberTitle','off','Name','Noisy Lake image');

imwrite(uint8(c),'Noisy Lake image.gif');

C = fft2(c, M1, N1);

% hFigure = imtool(abs(C),[]);
% set(hFigure,'NumberTitle','off','Name','FFT of Noisy Lake');
% 
% hFigure = imtool(log(1 + abs(C)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled FFT of Noisy Lake');

C_abs = abs(C);
C_grayscale = uint8(C_abs*255/max(max(C_abs)));
C_grayscale_scaled = log(1+C_abs);

imwrite(C_grayscale,'FFT of Noisy Lake.gif');
imwrite(uint8(C_grayscale_scaled*255/max(max(C_grayscale_scaled))),'Scaled FFT of Noisy Lake.gif');

%% Plotting shifted FFT of C

cm = double(zeros(M1,N1));

for x = 1:M1
    for y = 1:N1
        cm(x,y) = c(x,y)*((-1)^(x+y));
    end
end

Cm = fft2(cm, M1, N1);

% hFigure = imtool(abs(Cm),[]);
% set(hFigure,'NumberTitle','off','Name','Modulated FFT of Noisy Lake');
% 
% hFigure = imtool(log(1 + abs(Cm)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled, Modulated FFT Noisy Lake');

Cm_abs = abs(Cm);
Cm_grayscale = uint8(Cm_abs*255/max(max(Cm_abs)));
Cm_grayscale_scaled = log(1+Cm_abs);

imwrite(Cm_grayscale,'Modulated FFT of Noisy Lake.gif');
imwrite(uint8(Cm_grayscale_scaled*255/max(max(Cm_grayscale_scaled))),'Modulated Scaled FFT of Noisy Lake.gif');

%% Notch Filter Design

HN = double(ones(M1,N1));

HN(33,1) = 0;
HN(481, 1) = 0;

% hFigure = imtool(HN,[]);
% set(hFigure,'NumberTitle','off','Name','FFT of Notch Filter');
% 
% hFigure = imtool(log(1 + HN));
% set(hFigure,'NumberTitle','off','Name','Scaled FFT of Notch Filter');

imwrite(uint8(HN*255),'FFT of Notch Filter.gif');
imwrite(uint8(fftshift(HN)*255),'Modulated FFT of Notch Filter.gif');

%% Applying notch filter to image

G3 = double(zeros(M1,N1));

for u = 1 : M1
    for v = 1 : N1
        G3(u,v) = HN(u,v)*C(u,v);
    end
end

g3 = real(ifft2(G3));

G3_abs = abs(G3);
G3_grayscale = uint8(G3_abs*255/max(max(G3_abs)));
G3_grayscale_scaled = log(1+G3_abs);

imwrite(G3_grayscale,'FFT of Filtered Image.gif');
imwrite(uint8(G3_grayscale_scaled*255/max(max(G3_grayscale_scaled))),'Scaled FFT of Filtered Image.gif');


% hFigure = imtool(uint8(g3));
% set(hFigure,'NumberTitle','off','Name','Filtered Lake image');

imwrite(uint8(g3),'Filtered Lake image.gif');

%% Plotting shifted FFT of G3

g3m = double(zeros(M1,N1));

for x = 1:M1
    for y = 1:N1
        g3m(x,y) = g3(x,y)*((-1)^(x+y));
    end
end

G3m = fft2(g3m, M1, N1);

% hFigure = imtool(abs(G3m),[]);
% set(hFigure,'NumberTitle','off','Name','FFT of Filtered Lake');
% 
% hFigure = imtool(log(1 + abs(G3m)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled FFT of Filtered Lake');

G3m_abs = abs(G3m);
G3m_grayscale = uint8(G3m_abs*255/max(max(G3m_abs)));
G3m_grayscale_scaled = log(1+G3m_abs);

imwrite(G3m_grayscale,'Modulated FFT of Filtered Lake.gif');
imwrite(uint8(G3m_grayscale_scaled*255/max(max(G3m_grayscale_scaled))),'Modulated Scaled FFT of Filtered Lake.gif');

%% Difference image:

d = double(zeros(M1,N1));

for x = 1:M1
    for y = 1:N1
        d(x,y) = f_lake(x,y) - g3(x,y);
    end
end

% hFigure = imtool((d),[]);
% set(hFigure,'NumberTitle','off','Name','Difference image');

% hFigure = imtool(uint8(d*255));
% set(hFigure,'NumberTitle','off','Name','Difference image');

imwrite(uint8(d*255), 'Difference image.gif');

%% FFT of difference image

D = fft2(d, M1, N1);

% hFigure = imtool(abs(D),[]);
% set(hFigure,'NumberTitle','off','Name','FFT of difference image');
% 
% hFigure = imtool(log(1 + abs(D)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled FFT of difference image');

D_abs = abs(D);
D_grayscale = uint8(D_abs*255/max(max(D_abs)));
D_grayscale_scaled = log(1+D_abs);

imwrite(D_grayscale,'FFT of difference image.gif');
imwrite(uint8(D_grayscale_scaled*255/max(max(D_grayscale_scaled))),'Scaled FFT of difference image.gif');


%% Plotting shifted FFT of d

dm = double(zeros(M1,N1));

for x = 1:M1
    for y = 1:N1
        dm(x,y) = d(x,y)*((-1)^(x+y));
    end
end

Dm = fft2(dm, M1, N1);

% hFigure = imtool(abs(Dm),[]);
% set(hFigure,'NumberTitle','off','Name','Modulated FFT - difference image');
% 
% hFigure = imtool(log(1 + abs(Dm)),[]);
% set(hFigure,'NumberTitle','off','Name','Scaled, Modulated FFT - Diff image');

Dm_abs = abs(Dm);
Dm_grayscale = uint8(Dm_abs*255/max(max(Dm_abs)));
Dm_grayscale_scaled = log(1+Dm_abs);

imwrite(Dm_grayscale,'Modulated FFT - difference image.gif');
imwrite(uint8(Dm_grayscale_scaled*255/max(max(Dm_grayscale_scaled))),'Modulated Scaled FFT - difference image.gif');
