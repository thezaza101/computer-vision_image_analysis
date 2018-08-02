%% Lab6

clear all;
close all;

% load image
I = im2bw(imread('UPC-A_barcode.jpg'));

%find the start and end of the barcode
startPos = 0;
endPos = 0;

for r = 1:1:size(I,2)
    if I(150,r) == 0
        startPos = r;
        break;
    end
end

for r = size(I,2):-1:1
    if I(150,r) == 0
        endPos = r;
        break;
    end
end



width = endPos - startPos;

I2 = imcrop(I,[startPos 150 width 3]);


yR = I2(1,:);
xR = 1:size(yR,2);


figure(1);
subplot(1,2,1)
imshow(I)
title('Original Image')
subplot(1,2,2)
imshow(I2)
title('Cropped Image')







% b = Barcode;
% nextr = 1;
% r = 1;
% 
% while (r < 725)    
%     [bbar, nextr] = findBars(r,yR);    
%     b.Bars = [b.Bars, bbar];
%     if r == nextr
%         break;
%     end
%     r = nextr;
% end
% 
% for r = 1:1:size(b.Bars,2)
%    x = [b.Bars(r).StartBarEnd - b.Bars(r).StartBarStart,":",b.Bars(r).EndBarStart-b.Bars(r).StartBarEnd,":",b.Bars(r).EndBarEnd - b.Bars(r).EndBarStart];
%    disp(x);
% end
% 
% for r = 1:1:725
%     if yR(r) == 0
%         bar.StartBarStart = r;
%         for r1 = r:1:725
%             if yR(r1) == 1
%                 bar.StartBarEnd = r1;
%                 for r2 = r1:1:725
%                     if yR(r2) == 0
%                         bar.EndBarStart = r2;
%                         for r3 = r2:1:725
%                             if yR(r3) == 1
%                                 bar.EndBarEnd = r2;
%                                 b.Bars = [b.Bars, bar]
%                                 bar = upcaBar;                                
%                                 r = r2;
%                                 breakloop = true;
%                                 break;
%                             end
%                         end  
%                         if breakloop
%                             break;
%                         end
%                     end
%                 end
%                 if breakloop
%                     breakloop = false;
%                     break;                    
%                 end
%             end
%         end
%         
%     end
% end

% for r = 1:1:725
%     if yR(r) == 0 & barsFound ==0
%         bar.StartBarStart = r;
%         barsFound = 1;
%     end
%     if yR(r) == 1 & barsFound == 1
%         bar.StartBarEnd = r-1;
%     end
%     if yR(r) == 0 & barsFound == 1
%         bar.EndBarStart = r;
%         barsFound = 2;
%     end
%     if yR(r) == 1 & barsFound ==2
%         bar.EndBarEnd = r-1;
%         b.Bars = [b.Bars, bar]
%         bar = upcaBar;
%         barsFound = 0;
%         
%     end
% end



% for r = 1:1:725
%     if not(readingBar)
%         bar = upcaBar;
%     end
%     if yR(r) == 1        
%         readingBar = true;
%         if (not(foundFirstBar))
%             foundFirstBar = true;
%             bar.StartBarStart = r;
%             disp(r);
%             for rx = r+1:1:725
%                 if yR(rx) == 0
%                     bar.StartBarEnd = rx-1;
%                     r = rx;
%                     break;
%                 end                    
%             end
%         else
%            bar.EndBarStart = r;
%            for rx = r+1:1:725
%                if (yR(rx) == 0)
%                    bar.EndBarEnd = rx-1;
%                    r = rx;
%                    foundFirstBar = false;
%                    barsFound = barsFound + 1;
%                    b.Bars = [b.Bars, bar];
%                    readingBar = false;
%                    break;              
%                end
%            end
%            
%        end
%     end
% end

% figure(1);
% subplot(2,2,1), imshow(I);
% title('Original');
% 
% %Find Edge image
% CannyEdge = edge(I,'Canny'); 
% subplot(2,2,2), imshow(CannyEdge);
% title('Canny');
% 
% %plot the image
% subplot(2,2,3), plot(xR,yR);
% title('Plot');
% 
% % Plot the canny edge
% yRCanny = CannyEdge(150,:);
% subplot(2,2,4), plot(xR,yRCanny);
% title('Plot Canny');




% subplot(2,2,2), imshow(sat);
% title('Sat');
% subplot(2,2,4), imshow(val);
% title('Val');
