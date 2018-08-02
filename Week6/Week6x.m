%% Lab6

clear all;
close all;

% load image
I = im2bw(imread('UPC-A_barcode.jpg'));
yR = I(150,:);
xR = 1:size(yR,2);


b = Barcode;
nextr = 1;
r = 1;

while (r < 725)    
    [bbar, nextr] = findBars(r,yR);    
    b.Bars = [b.Bars, bbar];
    if r == nextr
        break;
    end
    r = nextr;
end

leftDigits =  [451,571,274,1051,2104,5101,2410,754,547,244];
rightDigits = [871,674,544,2131,247,277,242,2101,271,841];
sep = 242;

% for r = 1:1:size(leftDigits,2)
%     for y = 1:1:size(rightDigits,2)
%         disp([leftDigits(r), " vs ", rightDigits(y),isequal(leftDigits(r),rightDigits(y))]);
%     end
% end


numSep = 0;
for r = 1:1:size(b.Bars,2)
   x = str2num(strcat(num2str(b.Bars(r).StartBarEnd - b.Bars(r).StartBarStart),num2str(b.Bars(r).EndBarStart-b.Bars(r).StartBarEnd),num2str(b.Bars(r).EndBarEnd - b.Bars(r).EndBarStart)));
   outNum = 10;
   valueDet = false;
   if x == sep & numSep == 0
   %find the start
        numSep = 1;   
        outNum = "S";
        valueDet = true;
   end
   if  numSep == 1 & not(valueDet)
       for rl = 1:1:size(leftDigits,2)
           if x == sep 
                numSep = 2;   
                outNum = "M";
                valueDet = true;
                break;
           end
           if x == leftDigits(rl)
               outNum = rl-1;
               valueDet = true;
               break;
           end
       end
   end
   if  numSep == 2 & not(valueDet)
       for rl = 1:1:size(rightDigits,2)
           if x == sep 
                outNum = "E";
                valueDet = true;
                break;
           end
           if x == rightDigits(rl)
               outNum = rl-1;
               valueDet = true;
               break;
           end
       end
   end
   if(valueDet)
       disp(outNum);
   end
end




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
