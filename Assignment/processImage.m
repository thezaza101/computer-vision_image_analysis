function [sceneData] = processImage(InputRGBImg, inputSceneData)
%This function orchestrates the other functions required to analyses the image
sceneData = RoboCupSceneData;
%Enhance the image for faster processing
[I, sceneData.image, sceneData.cropRatio] = preProcessImage(InputRGBImg, 800);

%Attempt to find the ball
if ~exist('inputSceneData','var')
    %If no previous scene data has been provided...
    
    %Find the mask of the field, this will make finding the ball easier
    [sceneData.fieldMask, sceneData.fieldBindingBox] = FindField(I);
    
    %Apply the field mask to the image.
    maskedField = bsxfun(@times, I, cast(sceneData.fieldMask, 'like', I));
    [sceneData.ballMask, sceneData.ballBindingBox, sceneData.ballFound] = FindBall(maskedField);
else
    %If previous scence data has been provided...
    
    %Apply the field mask to the image based on previous scene data.
    maskedField = zeros(size(I),'single');
    sceneData.fieldBindingBox = inputSceneData.fieldBindingBox;
    x1 = inputSceneData.fieldBindingBox(1);
    x2 = inputSceneData.fieldBindingBox(1) + inputSceneData.fieldBindingBox(3) -1;
    y1 = inputSceneData.fieldBindingBox(2);
    y2 = inputSceneData.fieldBindingBox(2) + inputSceneData.fieldBindingBox(4) -1;
    maskedField(y1:y2,x1:x2,:) = I(y1:y2,x1:x2,:);
    sceneData.fieldMask = inputSceneData.fieldMask;
    
    %Find the ball based on previous field data
    [sceneData.ballMask, sceneData.ballBindingBox, sceneData.ballFound] = FindBall(maskedField, inputSceneData);
end


if ~exist('inputSceneData','var')
    sceneData.goalTemplateFeaturesExtracted = false;
    sceneData.goalLeftBindingBox = 0;
    sceneData.goalRightBindingBox = 0;
else
    sceneData.goalLeftFound = inputSceneData.goalLeftFound;
    sceneData.goalLeftBindingBox = inputSceneData.goalLeftBindingBox;
    sceneData.goalLeftFeaturePoints = inputSceneData.goalLeftFeaturePoints;
    sceneData.goalLeftFeatures = inputSceneData.goalLeftFeatures;
    
    sceneData.goalRightFound = inputSceneData.goalRightFound;
    sceneData.goalRightBindingBox = inputSceneData.goalRightBindingBox;
    sceneData.goalRightFeaturePoints = inputSceneData.goalRightFeaturePoints;
    sceneData.goalRightFeatures = inputSceneData.goalRightFeatures;
    sceneData.goalTemplateFeaturesExtracted = inputSceneData.goalTemplateFeaturesExtracted;
end


%Find the goal lines
[sceneData] = FindGoal(InputRGBImg, sceneData);

[sceneData.fieldLines] = FindFieldLines(I, sceneData);
end