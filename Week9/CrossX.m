%Week 9 Cross

close all;
clear;
clc;
im_path = 'robocup_image1.jpeg';
im = rgb2gray(imread(im_path));


x_start = 89;
y_start = 406;

x_end = 141;
y_end = 451;

template = im(y_start:y_end, x_start:x_end, :);


NCC_Values = normxcorr2(template, im);
figure; surf(NCC_Values), shading flat;
[ypeak, xpeak] = find(NCC_Values==max(NCC_Values(:)));
yoffSet = ypeak-size(template,1);
xoffSet = xpeak-size(template,2);


figure
imshow(im);
imrect(gca, [xoffSet+1, yoffSet+1, size(template,2), size(template,1)]);



%figure; imshow(NCC_Values);