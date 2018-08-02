function [hue, sat, val] = colourAnalysis(inInputRGBImg) 
    hsv = rgb2hsv(inInputRGBImg);
    ImSize = size(inInputRGBImg);
    h =  zeros(ImSize);
    s =  zeros(ImSize);
    v =  zeros(ImSize);
    hue = hsv(:,:,1);
    sat = hsv(:,:,2);
    val = hsv(:,:,3);
end