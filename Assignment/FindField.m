function [val, bindingBox] = FindField(InputRGBImg)
%This function attempts mask the field by looking for the largest 5
%connected green elements in the image. 

%There is an assumption being made that the largest green elements in the
%image is the field

%Find the greenest areas of the image
[greenAreas] = findColourZoneMask(InputRGBImg, 'g',1,1.5,1);
%Get the largest connected green object and return its value
largestElements = bwareafilt(greenAreas,5);

%Morphologically close mask and return the value
se = strel('disk',35);
val = imclose(largestElements,se);

%Determine the binding box of the field
bindingBox = regionprops(val,'BoundingBox');
bindingBox = round(bindingBox(1).BoundingBox);

end