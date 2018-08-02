function [sceneData] = drawScene(sceneData)
%This function draws the output image based on the calculated scene data

%show the image
figure(4), imshow(sceneData.image), hold on
max_len = 0;

%draw the field lines
for k = 1:length(sceneData.fieldLines)
    xy = [sceneData.fieldLines(k).point1; sceneData.fieldLines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
    % Plot beginnings and ends of lines
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
    % Determine the endpoints of the longest line segment
    len = norm(sceneData.fieldLines(k).point1 - sceneData.fieldLines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end
end

%draw the left goal post bounding box and text
if (sceneData.goalLeftFound)
    try
        rectangle('Position', sceneData.goalLeftBindingBox,...
            'EdgeColor','m', 'LineWidth', 1)
        GL= text(double(sceneData.goalLeftBindingBox(1)), double(sceneData.goalLeftBindingBox(2)-20),'Goal Post Left','Color','m','FontSize',14);
    catch
    end
end

%draw the right goal post bounding box and text
if (sceneData.goalRightFound)
    try
        rectangle('Position', sceneData.goalRightBindingBox,...
            'EdgeColor','m', 'LineWidth', 1)
        GR= text(double(sceneData.goalRightBindingBox(1)), double(sceneData.goalRightBindingBox(2)-20),'Goal Post Right','Color','m','FontSize',14);
    catch
    end
end

%Draw the ball bounding box and text
if sceneData.ballFound
    rectangle('Position', sceneData.ballBindingBox,...
        'EdgeColor','b', 'LineWidth', 1)
    B= text(sceneData.ballBindingBox(1), sceneData.ballBindingBox(2)-20,'Ball','Color','b','FontSize',14);
end

%draw the field bounding box and text
rectangle('Position', sceneData.fieldBindingBox,...
    'EdgeColor','c', 'LineWidth', 1)
F= text(sceneData.fieldBindingBox(1)/2, sceneData.fieldBindingBox(2)-20,'Field','Color','c','FontSize',14);
hold off



end