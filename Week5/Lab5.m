%%Lab 5

clear all;

%Load image
I = imread('robocup_image1.jpeg');
Ix = imread('robocup_image2.jpeg');

%convert to gray
gryLevel = graythresh(I);
iBW = im2bw(I, gryLevel);
rotI = imrotate(iBW,33,'crop');

%find edges
ED = edge(iBW,'canny');

%hough
[H, theta, rho] = hough(ED); 
figure(1);
imshow(H,[],'XData',theta,'YData',rho, 'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

%Find peaks
peaks  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = theta(peaks(:,2)); y = rho(peaks(:,1));
plot(x,y,'s','color','white');


[hue, sat, val] = colourAnalysis(I);
huex = hue .* 360;
figure(5);
subplot(2,2,1), imshow(I);
title('Original');
subplot(2,2,3), imshow(hue);
title('Hue');
subplot(2,2,2), imshow(sat);
title('Sat');
subplot(2,2,4), imshow(val);
title('Val');

[huex, satx, valx] = colourAnalysis(Ix);
figure(6);
subplot(2,2,1), imshow(Ix);
title('Originalx');
subplot(2,2,3), imshow(huex);
title('Huex');
subplot(2,2,2), imshow(satx);
title('Satx');
subplot(2,2,4), imshow(valx);
title('Valx');



%Find lines
lines = houghlines(iBW,theta,rho,peaks,'FillGap',5,'MinLength',7);
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end