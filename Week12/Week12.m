%%Week12
clear all;
close all;

wally1 = rgb2gray(imread('wally_from_book1_pic1_top_image.tif'));
% wally2 = rgb2gray(imread('WALLY2.TIF'));
% wally3 = rgb2gray(imread('WALLY3.TIF'));
% wally4 = rgb2gray(imread('WALLY4.TIF'));
% wallyBook = rgb2gray(imread('wally_from_book1_pic1_10pc.tif'));
% wallyBookMod = rgb2gray(imread('wally_from_book1_pic1_top_image.tif'));

book = rgb2gray(imread('book1_pic1_10pc.tif'));
% bookPart = rgb2gray(imread('book1_pic1_10pc_modified.tif'));

wally1Features = detectSURFFeatures(wally1);
% wally2Features = detectSURFFeatures(wally2); 
% wally3Features = detectSURFFeatures(wally3);
% wally4Features = detectSURFFeatures(wally4);
% wallyBookFeatures = detectSURFFeatures(wallyBook);
% wallyBookModFeatures = detectSURFFeatures(wallyBookMod);

bookFeatures = detectSURFFeatures(book);
% bookPartFeatures = detectSURFFeatures(bookPart);


[wally1Features, wally1FeaturesPoints] =...
        extractFeatures(wally1, wally1Features);
    
[bookFeatures, bookFeaturesPoints] =...
        extractFeatures(book, bookFeatures);
    
boxPairs = matchFeatures(wally1Features, bookFeatures);
    
matchedWally1Points = wally1FeaturesPoints(boxPairs(:, 1), :);
matchedBookPoints = bookFeaturesPoints(boxPairs(:, 2), :);
    
[tForm, inlierWallyPoints, inlierBookPoints] =...
        estimateGeometricTransform(matchedWally1Points, matchedBookPoints, 'affine');
    
figure; showMatchedFeatures(wally1,book,inlierWallyPoints,inlierBookPoints);
    