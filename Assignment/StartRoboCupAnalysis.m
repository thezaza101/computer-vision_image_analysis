%This is the script that needs to be run to analyse the robocup
%images/video

%%clear the workspace
close all;
clear all;

%%Uncomment the file you wish to run the analysis over

% fileName = 'Robocup_Level1_image1.jpg';
% fileName = 'Robocup_Level1_image2.jpg';
% fileName = 'Robocup_Level1_image3.jpg';
% fileName = 'Robocup_Level2_image1.jpg';
 fileName = 'Robocup_Level2_image2.jpg';
% fileName = 'Robocup_Level2_image3.jpg';
% fileName = 'Robocup2015_12s.mp4';

%if the file in an image
if (isempty(strfind(fileName, '.mp4')))

    %load the image
    I = imread(fileName);
    %process the image
    [sceneData] = processImage(I);
    %draw the image based on processed data
    [sceneData] = drawScene(sceneData);

%if the file is a video
else
    %open the video file reader
    vid = vision.VideoFileReader(fileName);
    
    %get metadata about the video
    xyloObj = VideoReader(fileName);
    info = get(xyloObj);
    
    frameCount = 1;
    frameRateDivisor = round(info.FrameRate/4);
    
    while ~isDone(vid)
        I = step(vid);
        %Run the image analysis every x seconds (.25 sec by default) and
        %for the first frame. for the remaining frames used the previousley
        %calculated data to draw the position of the objects we are
        %intersted in
        if ((mod(frameCount, frameRateDivisor) == 0) | frameCount==1)
            if exist('sceneData','var')
                [sceneData] = processImage(I, sceneData);
            else
                [sceneData] = processImage(I);
            end
        else
            [I, sceneData.image, cropRatio] = preProcessImage(I, 800);
        end
        
        frameCount = frameCount+1;
        [sceneData] = drawScene(sceneData);
    end
end