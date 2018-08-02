%Week 3 Tute

%Clear the workspace
clear all;
close all;

%Load the image
imgBC = imread('barcode_cropped.jpg');
imgBCHisEQ = histeq(imgBC);

figure(1);
subplot(2,2,1), imshow(imgBC);
title('Original Image');
subplot(2,2,3), imhist(imgBC);
title('Original Image Hist');
subplot(2,2,2), imshow(imgBCHisEQ);
title('HistEQ Image');
subplot(2,2,4), imhist(imgBCHisEQ);
title('HistEQ Image Hist');

imgBCEQRed = histeq(imgBC(:,:,1));
imgBCEQGreen = histeq(imgBC(:,:,2));
imgBCEQBlue = histeq(imgBC(:,:,3));

imgChannelHisEQRGB = imgBC;
imgChannelHisEQRGB(:,:,1) = imgBCEQRed;
imgChannelHisEQRGB(:,:,2) = imgBCEQGreen;
imgChannelHisEQRGB(:,:,3) = imgBCEQBlue;

figure(2);
subplot(2,2,1), imshow(imgBCEQRed);
title('Red hist EQ');
subplot(2,2,3), imshow(imgBCEQGreen);
title('Green hist EQ');
subplot(2,2,2), imshow(imgBCEQBlue);
title('Blue hist EQ');
subplot(2,2,4), imshow(imgChannelHisEQRGB);
title('RGB channel Hist EQ');

figure(3);
subplot(1,2,1), imshow(imgBCHisEQ);
title('Original hist EQ');
subplot(1,2,2), imshow(imgChannelHisEQRGB);
title('Channel Hist EQ merge');

