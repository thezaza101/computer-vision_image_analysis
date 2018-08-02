%Week 3 homework

%Clear the workspace
clear all;
close all;

%Load the image
img1 = imread('DINGO3_Background.jpeg');
img2 = imread('DINGO3_Frame0.jpeg');

imDiff = img2 - img1;

overallMin = min(min(imDiff)); 
overallMax = max(max(imDiff));


Z = imabsdiff(img1,img2);

figure(1);
subplot(2,2,1), imshow(img1);
title('Original Image 1');
subplot(2,2,3), imshow(img2);
title('Original Image 2');
subplot(2,2,2), imshow(Z);
title('imabsdiff');
subplot(2,2,4), imshow(imDiff);
title('Image 2 - Image 1');

imGreyDiff = rgb2gray(imDiff);

imgStreach = imDiff

for iR = 1:1:360
    for iC = 1:1:564
        if (img1(iR, iC) < overallMin)
            imgStreach(iR, iC,:) = 0;
        end
        if (img1(iR, iC) > overallMax)
            imgStreach(iR, iC,:) = 0;
        end
    end
end



figure(2);
imshow(imgStreach);