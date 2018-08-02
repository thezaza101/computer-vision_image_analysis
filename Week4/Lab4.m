%%Lab 4

clear all;

% Load images - Change file path to your current settings!
backgroundImg = imread('DINGO3_Background.jpg');
dingoImg = imread('DINGO3_Frame0.jpeg');

% [mask, cutout] = computeBackgroundSubtractedImg(dingoImg,backgroundImg);
% 
% figure(1);
% subplot(2,1,1), imshow(mask);
% title('Mask');
% subplot(2,1,2), imshow(cutout);
% title('Cutout');

fileNames = dir(['*.jpeg']);
iNumImgFiles = size(fileNames);

for iF = 1:iNumImgFiles(1) 
   inputImg = imread([fileNames(iF).name]); 
   
   [mask, cutout] = computeBackgroundSubtractedImg(inputImg,backgroundImg);
   
   figure(iF);
    subplot(2,1,1), imshow(mask);
    title('Mask');
    subplot(2,1,2), imshow(cutout);
    title('Cutout');
   
end




function [binMaskImg, cutOutImg] = computeBackgroundSubtractedImg(inInputImg, inBackgroundImg) 

funcImgDiff = inInputImg - inBackgroundImg;

funcimGrey = rgb2gray(funcImgDiff);
funcLowTH = 5;
funcHighTH = 255;

funcGrMasy = funcimGrey;

for iR = 1:1:360
    for iC = 1:1:564
        if ~(funcimGrey(iR, iC) > funcLowTH && funcimGrey(iR, iC) < funcHighTH)
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
%dilatedImg1 = imdilate(funcBW, se);
FuncErodedImg = imerode(funcBW, se);

%ImSize = [360, 564, 3];
ImSize = size(inInputImg);
FuncErode3D = zeros(ImSize, 'uint8');
FuncErode3D(:,:,1) = FuncErodedImg;
FuncErode3D(:,:,2) = FuncErodedImg;
FuncErode3D(:,:,3) = FuncErodedImg;

binMaskImg = FuncErodedImg;
cutOutImg = inInputImg .* FuncErode3D;



end