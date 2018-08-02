%Week 2 Tute

%Clear the workspace
clear all;
close all;

%Load the image
img = imread('chocolate_original.jpg');

%Resize the image
imgRes = imresize(img, [480 640]);

%Red channel
imgRed = imgRes(:,:,1);

%Green channel
imgGreen = imgRes(:,:,2);

%Blue channel
imgBlue = imgRes(:,:,3);

%Grey scale
imgGrey = rgb2gray(imgRes);

%ReRed = zeros(480, 640, 3);
%ReRed(:,:,1) = imgRed/255;
%figure(5);
%imshow(ReRed);

% %show the images
% %figure('Red',1);
% figure(1);
% imshow(imgRed);
% %figure('Green',2);
% figure(2);
% imshow(imgGreen);
% %figure('Blue',3);
% figure(3);
% imshow(imgBlue);
% %figure('Grey',4);
% figure(4);
% imshow(imgGrey);
% 
% figure(6);
% imshow(imgRes);
% 
% % Threshold image Grey
% level = graythresh(imgGrey);
% BW = im2bw(imgGrey,level);
% figure(7);
% imshow(BW);
% 
% % Threshold image Red
% level = graythresh(imgRed);
% BW = im2bw(imgGrey,level);
% figure(8);
% imshow(BW);
% 
% % Threshold image Green
% level = graythresh(imgGreen);
% BW = im2bw(imgGrey,level);
% figure(9);
% imshow(BW);
% 
% % Threshold image Blue
% level = graythresh(imgBlue);
% BW = im2bw(imgGrey,level);
% figure(10);
% imshow(BW);
% 
% 
% % Threshold loop image Gr
% for iI = 0.0:0.01:1.0
%     thresholdedImg = im2bw(imgGrey, iI);
%     figure(11);
%     imshow(thresholdedImg);
%     pause(0.01);
% end
% 
% % Threshold loop image R
% for iI = 0.0:0.01:1.0
%     thresholdedImg = im2bw(imgRed, iI);
%     figure(12);
%     imshow(thresholdedImg);
%     pause(0.01);
% end
% 
% % Threshold loop image G
% for iI = 0.0:0.01:1.0
%     thresholdedImg = im2bw(imgGreen, iI);
%     figure(13);
%     imshow(thresholdedImg);
%     pause(0.01);
% end
% 
% % Threshold loop image B
% for iI = 0.0:0.01:1.0
%     thresholdedImg = im2bw(imgBlue, iI);
%     figure(14);
%     imshow(thresholdedImg);
%     pause(0.01);
% end

% figure(15);
% imhist(imgBlue);
% 
% % Threshold image Blue
% blueChannelAfterLowerThreshold = im2bw(imgBlue,30/255.);
% figure(16);
% imshow(blueChannelAfterLowerThreshold);
% 
% 
% blueChannelAfterHigherThreshold = im2bw(imgBlue,80/255.);
% figure(17);
% imshow(blueChannelAfterHigherThreshold);
% 
% 
% 
% blueChannelMiddleRange = blueChannelAfterLowerThreshold - blueChannelAfterHigherThreshold;
% figure(18);
% imshow(blueChannelMiddleRange);


blueChannelBinaryMask = zeros(480, 640);
lowTH = 30
highTH = 80

%Homework Week 2
for iR = 1:1:480
    for iC = 1:1:640
        if ~(imgBlue(iR, iC) > lowTH && imgBlue(iR, iC) < highTH)
            blueChannelBinaryMask(iR, iC) = 1;
        else
            blueChannelBinaryMask(iR, iC) = 0;
        end
    end    
end


% %% Complement Image and Fill in holes
se = strel('square', 3);
ImgBlueChMaskFilled = imopen(blueChannelBinaryMask,se);


imgGreyMask = imgGrey;

for iR = 1:1:480
    for iC = 1:1:640
        if (ImgBlueChMaskFilled(iR, iC) < 1)           
            imgGreyMask(iR, iC, :) = 0;
        end
    end    
end

imHighContrustGreyMask = histeq(imgGreyMask);



figure(22);
subplot(2,3,1), imshow(blueChannelBinaryMask);
title('Original blue filter mask');
subplot(2,3,2), imshow(imgGreyMask);
title('Grey Mask');
subplot(2,3,3), imshow(imHighContrustGreyMask);
title('HC Grey Mask');
subplot(2,3,4), imshow(ImgBlueChMaskFilled);
title('Morphological Structuring');
subplot(2,3,5), imhist(imgGreyMask);
title('Histogram');
subplot(2,3,6), imhist(imHighContrustGreyMask);
title('HC Histogram');

% 
% InverseblueChannelAfterHigherThreshold = inverse(blueChannelAfterHigherThreshold);
% figure(19);
% imshow(InverseblueChannelAfterHigherThreshold);