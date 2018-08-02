function [lines] = FindFieldLines(I,inputSceneData)
%This function attempts to find the field lines using the hough method

%Determine the image coordinates based on the field binding box
x1 = inputSceneData.fieldBindingBox(1);
y1 = inputSceneData.fieldBindingBox(2);
x2 = inputSceneData.fieldBindingBox(1)+inputSceneData.fieldBindingBox(3)-2;
y2 = inputSceneData.fieldBindingBox(2)+inputSceneData.fieldBindingBox(4)-2;

%extract the field image
originalSizeOfImage = size(I(:,:,:));
fieldImage = zeros(originalSizeOfImage,'uint8');
fieldImage(y1:y2, x1:x2,:) = I(y1:y2, x1:x2,:);
%Adjust the field image
gryLevel = graythresh(histeq(I));
fieldImageGray = imgaussfilt(fieldImage, 3);
fieldImageGray = im2bw(fieldImageGray, gryLevel);

%get the brightest areas of the field
fieldHSV = rgb2hsv(fieldImage);
highValueFieldMask = fieldHSV(:,:,3) > 0.9;
fieldImageGray = bsxfun(@times, fieldImageGray, cast(highValueFieldMask, 'like', fieldImageGray));

%find the edges
ED = edge(fieldImageGray,'log');


%hough
[H, theta, rho] = hough(ED);
%Find peaks
peaks  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
%find the lines
lines = houghlines(fieldImageGray,theta,rho,peaks,'FillGap',40,'MinLength',20);

end