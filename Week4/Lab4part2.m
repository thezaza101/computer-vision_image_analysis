%%Lab 4 Part 2

clear all;

%% Load image
imgBarCode = imread('barcode.jpg');
I =  rgb2gray(imgBarCode);

ED = edge(I,'canny');
%ED = imrotate(ED,45);

[H, theta, rho] = hough(ED); 

% Display the original image. 
subplot(2,1,1); 
imshow(I); 
title('Input Image'); 

% Display the Hough matrix. 
subplot(2,1,2);
imshow(imadjust(rescale(H)),'XData',theta,'YData',rho, 'InitialMagnification','fit');
title('Hough Transform of the Input Image');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot);



