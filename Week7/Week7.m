%week 7
close all;
clear all;

%read the image
I = imread('robocup_image1.jpeg');
%determine the template ball image
tempateBallImage = I(407:450,97:138,:);
Igr = rgb2gray(I);
tpgr = rgb2gray(tempateBallImage); 
imOrgSize = size(im2bw(I));
templateSize = size(im2bw(tempateBallImage));

SadVal = zeros(imOrgSize);

templateHeightHalf = round(templateSize(1)/2);
templateWidthHalf = round(templateSize(2)/2);

strow = templateHeightHalf+1;
edrow = imOrgSize(1)-templateHeightHalf;

stCol = templateWidthHalf+1;
edCol = imOrgSize(2)-templateWidthHalf;

for r=strow:1:edrow
    for c=stCol:1:edCol
        iRowStart = r- templateHeightHalf;
        iRowEnd = r+templateSize(1)-1;
        iColStart = c-templateWidthHalf;
        iColEnd = c+templateSize(2)-1;
        
        currentImgOverlay = Igr(iRowStart:iRowEnd,iColStart:iColEnd);
       
       SadVal(r,c) = determineSad(tpgr, currentImgOverlay);
    end
end
figure(1);
imshow(SadVal);
%imshow(SadVal);