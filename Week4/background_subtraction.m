% Background subtraction example on thermal images
% Author: Roland Goecke, (c) 2018

clear all;

% Load images - Change file path to your current settings!
backgroundImg = imread('DINGO3_Background.jpg');
dingoImg = imread('DINGO3_Frame0.jpeg');

% % Display images
% figure(1);
% imshow(backgroundImg);

figure(2);
imshow(dingoImg);

% Compute difference image
% (Literally, subtract the background image from the current image.)
diffImg = dingoImg - backgroundImg;
% 
% % Find the minimum pixel value. Divide by 255 as we will need this value
% % to be in the range of 0 to 1.
% minPixelValue = double(min(min(diffImg)))/255.0;
% disp(minPixelValue);
% 
% % Find the maximum pixel value. Divide by 255 as we will need this value
% % to be in the range of 0 to 1.
% maxPixelValue = double(max(max(diffImg)))/255.0;
% disp(maxPixelValue);
% 
% % Display difference image without rescaling
% figure(3);
% imshow(diffImg);
% 
% % Display difference image with rescaling
% rescaledDiffImg = imadjust(diffImg, ...
%                     [minPixelValue(1) minPixelValue(2) minPixelValue(3); ...
%                      maxPixelValue(1) maxPixelValue(2) maxPixelValue(3)], ...
%                  []);
% figure(4);
% imshow(rescaledDiffImg);
% 
% % Convert into greyscale image
% greyDiffImg = rgb2gray(rescaledDiffImg);
% figure(5);
% imshow(greyDiffImg);
% 
% % Threshold image
% thresholdedImg = im2bw(greyDiffImg, 0.1);
% figure(6);
% imshow(thresholdedImg);
% 
% % Morphological operations 
% % First, dilate the binary image
% se = strel('disk', 4, 4);
% dilatedImg = imdilate(thresholdedImg, se);
% figure(7);
% imshow(dilatedImg);
% 
% % Secondly, erode the dilated image
% erodedImg = imerode(dilatedImg, se);
% figure(8);
% imshow(erodedImg);
% 
% % Now apply mask to original image
% imgSize = size(erodedImg);
% maskedOrigImg = dingoImg;
% for iRow = 1:imgSize(1)
%     for iCol = 1: imgSize(2)
%         if (erodedImg(iRow, iCol) == 0)
%             maskedOrigImg(iRow, iCol, :) = 0;
%         end
%     end
% end
% figure(9);
% imshow(maskedOrigImg);

%%Asdf

imGrey = rgb2gray(diffImg);
lowTH = 5
highTH = 255

GrMasy = imGrey;

% figure(10);
% imshow(GrMasy);



for iR = 1:1:360
    for iC = 1:1:564
        if ~(imGrey(iR, iC) > lowTH && imGrey(iR, iC) < highTH)
            GrMasy(iR, iC, :) = 0;
        else
            GrMasy(iR, iC, :) = 1;
        end
    end    
end

level = graythresh(GrMasy);
BW = im2bw(GrMasy,level);


se = strel('disk', 4, 4);
dilatedImg1 = imdilate(BW, se);
% figure(11);
% imshow(dilatedImg1);

% Secondly, erode the dilated image
erodedImg2 = imerode(BW, se);
% figure(12);
% imshow(erodedImg2);

Cutout = dingoImg;

% for iR = 1:1:360
%     for iC = 1:1:564
%         if (erodedImg2(iR, iC) == 0)
%             Cutout(iR, iC, :) = 0;
%         end
%     end    
% end


%ImSize = [360, 564, 3];
ImSize = size(dingoImg);
erode3D = zeros(ImSize, 'uint8');
erode3D(:,:,1) = erodedImg2;
erode3D(:,:,2) = erodedImg2;
erode3D(:,:,3) = erodedImg2;

Cutout = dingoImg .* erode3D;




figure(13);
imshow(Cutout);


function [binMaskImg, cutOutImg] = computeBackgroundSubtractedImg(inInputImg, inBackgroundImg) 

funcImgDiff = inInputImg - inBackgroundImg;

funcimGrey = rgb2gray(funcImgDiff);
funcLowTH = 5
funcHighTH = 255

funcGrMasy = funcimGrey;

for iR = 1:1:360
    for iC = 1:1:564
        if ~(funcimGrey(iR, iC) > lowTH && funcimGrey(iR, iC) < highTH)
            funcGrMasy(iR, iC, :) = 0;
        else
            funcGrMasy(iR, iC, :) = 1;
        end
    end    
end

funcLevel = graythresh(funcGrMasy);
funcBW = im2bw(funcGrMasy,funcLevel);

%%
se = strel('disk', 4, 4);
%dilatedImg1 = imdilate(BW, se);
FuncErodedImg = imerode(BW, se);

%ImSize = [360, 564, 3];
ImSize = size(dingoImg);
FuncErode3D = zeros(ImSize, 'uint8');
FuncErode3D(:,:,1) = FuncErodedImg;
FuncErode3D(:,:,2) = FuncErodedImg;
FuncErode3D(:,:,3) = FuncErodedImg;

OutputCutout = inInputImg .* FuncErode3D;



end