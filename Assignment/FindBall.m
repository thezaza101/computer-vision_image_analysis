function [val, bindingBox, foundBall] = FindBall(InputRGBImg, inputSceneData)
%This function attempts mask the ball by looking for the largest
%connected red element in the image.

%There is an assumption being made that the largest connected red element in the
%image is the ball

foundBall = false;
sizeOfImage = size(InputRGBImg(:,:,1));
searchArea = [1 1 sizeOfImage(1) sizeOfImage(2)];

%Find the reddest areas of the image
if ~exist('inputSceneData','var')
    [ballMask] = findColourZoneMask(InputRGBImg, 'r',1,2,2);
else
    
    x1 = inputSceneData.fieldBindingBox(1);
    x2 = inputSceneData.fieldBindingBox(1) + inputSceneData.fieldBindingBox(3) -1;
    y1 = inputSceneData.fieldBindingBox(2);
    y2 = inputSceneData.fieldBindingBox(2) + inputSceneData.fieldBindingBox(4) -1;
    
    [ballMask] = findColourZoneMask(InputRGBImg(y1:y2,x1:x2,:), 'r',1,2,2);
    searchArea = [y1 x1 y2 x2];
end


%     figure(10);
%     imshow(ballMask);
%Return the largest connected red object
val = zeros(size(sizeOfImage),'logical');

val(searchArea(1):searchArea(3), searchArea(2):searchArea(4)) = bwareafilt(ballMask,1);
region = regionprops(val,'BoundingBox');


%Determine the binding box of the ball
if size(region,1) > 0
    bindingBox = round(region(1).BoundingBox);
    foundBall = true;
else
    bindingBox = 0;
end

end