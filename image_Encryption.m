%Clear Function
clc;
clear;
close all;

% Input the Image here in imread from the data set
img = imread('dataset\image5.png');
figure('Name','Input_Image') 
imshow(img);
title('Original Image')

% Image converted from RGB to Greyscale
img = rgb2gray(img);
figure('Name','Image Conversion') 
imshow(img);
title('Image converted from RGB to Greyscale')
tic
timg = img;
r = 3.62;
x(1) = 0.7;
row = size(img,1);
col = size(img,2);
s = row*col;


%Creation of Logistic function
for n=1:s-1
    x(n+1) = r*x(n)*(1-x(n));
end

[so,in] = sort(x);


%Start of Confusion
timg = timg(:);
for m = 1:size(timg,1)
    
    t1 = timg(m);
    timg(m)=timg(in(m));
    timg(in(m))=t1; 
end


%Creation of diffusion key
p=3.628;
k(1)=0.632;
for n=1:s-1
    k(n+1) = cos(p*acos(k(n)));
end
k = abs(round(k*255));

ktemp = de2bi(k);
ktemp = circshift(ktemp,1);
ktemp = bi2de(ktemp)';
key = bitxor(k,ktemp);


%Final Encryption Starts
timg = timg';
timg = bitxor(uint8(key),uint8(timg));
himg = reshape(timg,[row col]);
%Encrypted Image 
figure('Name','Encryption_Result')         
imshow(himg);
title('Encrypted Image')

toc

%Decryption Start
timg = bitxor(uint8(key),uint8(timg));
timg = timg(:);
for m = size(timg,1):-1:1
    
    t1 = timg(m);
    timg(m)=timg(in(m));
    timg(in(m))=t1;
end


% Output 
timg = reshape(timg,[row col]);


% Decrypted Image
figure('Name','Decryption_Result') 
imshow(timg);
title('Decrypted Image')


% Histogram of Orignal Image
figure('Name','Histogram of Input')
imhist(img);
title('Histogram of Orignal GreyScale Image')


% Histogram of Encrypted Image
figure('Name','Histogram of Encryption')
imhist(himg); 
title('Histogram of Encrypted Image')

