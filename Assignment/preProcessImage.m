function [outEnhanced, resizedImage, cropRatio] = preProcessImage(InputRGBImg, Width)
%This function resizes the image to a desired width and enhances the image
    cropRatio = Width / size(InputRGBImg,1);    
    resizedImage=imresize(InputRGBImg, cropRatio);
    outEnhanced = histeq(resizedImage);    
end