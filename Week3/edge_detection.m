%Week 3 Tute

%Clear the workspace
clear all;
close all;

%Load the image
imgBC = imread('barcode_cropped.jpg');
imgBCGrey = rgb2gray(imgBC);

imgBCGreySobel = edge(imgBCGrey,'Sobel');
imgBCGreyCanny = edge(imgBCGrey,'Canny'); 

% figure(1);
% subplot(2,2,1), imshow(imgBC);
% title('Original Image');
% subplot(2,2,3), imshow(imgBCGrey);
% title('Greyscale');
% subplot(2,2,2), imshow(imgBCGreySobel);
% title('Sobel edge');
% subplot(2,2,4), imshow(imgBCGreyCanny);
% title('Canny edge');

%%Step 9
%Load the image
img = imread('chocolate_original.jpg');
%Resize the image
imgRes = imresize(img, [480 640]);
%Blue channel
imgBlue = imgRes(:,:,3);
%Grey scale
imgGrey = rgb2gray(imgRes);

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


% Complement Image and Fill in holes
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

imgHighContrustGreyMask = histeq(imgGreyMask);


imgChocGreySobel = edge(imgHighContrustGreyMask,'Sobel');
imgChocGreyCanny = edge(imgHighContrustGreyMask,'Canny'); 

figure(2);
subplot(2,2,1), imshow(imgGrey);
title('Original Grey');
subplot(2,2,2), imshow(imgHighContrustGreyMask);
title('Masked Grey Hist EQ');
subplot(2,2,3), imshow(imgChocGreySobel);
title('Sobel edge');
subplot(2,2,4), imshow(imgChocGreyCanny);
title('Canny edge');

%% Test edge

se90 = strel('line', 3, 90)
se0 = strel('line', 3, 0)

BWsdill = imdilate(imgChocGreyCanny, [se90 se0]);
BWdfill = imfill(BWsdill, 'holes');

seD = strel('diamond',1);
BWfinal = imerode(BWdfill,seD);

se = strel('square', 40);
BWfinal = imopen(BWfinal,se);


BWoutline = bwperim(BWfinal);
Segout = imgGrey;
Segout(BWoutline) = 255;

imgTest = imgRes;

for iR = 1:1:480
    for iC = 1:1:640
        if (BWfinal(iR, iC) < 1)           
            imgTest(iR, iC, :) = 0;
        end
    end    
end

figure(3);
subplot(2,2,1), imshow(imgHighContrustGreyMask);
title('Masked Grey Hist EQ');
subplot(2,2,2), imshow(BWfinal);
title('FInal Mask');
subplot(2,2,3), imshow(imgChocGreyCanny);
title('Canny edge');
subplot(2,2,4), imshow(imgTest);
title('Masked original');

