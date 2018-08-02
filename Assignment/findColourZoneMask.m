function [out] = findColourZoneMask(InputRGBImg, colourToFind, rThresh,gThresh,bThresh)
%This function will create a mask for the input 'colourToFind'. this is
%achieved by comparing the that the colour channel vale of the colour to find is
%always greater than the sum of the other 2 colour channel values. The
%colour channel values can be multiplyed by a threashold for fine tuning.

if colourToFind=='r'
    out = (InputRGBImg(:,:,1)*rThresh) > ((InputRGBImg(:,:,2)*gThresh)+(InputRGBImg(:,:,3)*bThresh));
end
if colourToFind=='g'
    out = (InputRGBImg(:,:,2)*gThresh) > ((InputRGBImg(:,:,1)*rThresh)+(InputRGBImg(:,:,3)*bThresh));
end
if colourToFind=='b'
    out = (InputRGBImg(:,:,3)*bThresh) > ((InputRGBImg(:,:,1)*rThresh)+(InputRGBImg(:,:,2)*gThresh));
end
end