%Week 9
close all;
clear all;

%read the image
I = imread('robocup_image1.jpeg');
%determine the template ball image
tempateBallImage = I(407:450,97:138,:);