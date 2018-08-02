function [SAD] = determineSad(imgtoFind, imgLookIn)

diff = abs(imgLookIn - imgtoFind);
SAD = sum(diff,2);

%     SAD = 0;
%     imExtendedImage
%     
%     imcrop = imgLookIn(r:size(imgtoFind,1), c:size(imgtoFind,2),:);
%     diff = imcrop - imgtoFind;
%     imshow(diff);
%     
% %     for r1=r:1:size(imgtoFind,1)
% %         for c1=c:1:size(imgtoFind,2)
% %             for z1=1:1:size(imgtoFind,3)
% %                 SAD = SAD + (imgLookIn(r1, c1,z1) - imgtoFind(r1, c1,z1));
% %             end            
% %         end
% %     end
end