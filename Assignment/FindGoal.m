function [sceneData] = FindGoal(InputRGBImg, sceneData)
%This function attempts to find the goal posts using feature matching

%Extract the features of the template images if they haven’t been
%extracted before
if ~(sceneData.goalTemplateFeaturesExtracted)
    templateRightImage = rgb2gray(imread('TemplateGoalRight.jpg'));
    goalRightFeaturePoints = detectSURFFeatures(templateRightImage);
    [sceneData.goalRightFeatures, sceneData.goalRightFeaturePoints] =...
        extractFeatures(templateRightImage, goalRightFeaturePoints);
    
    
    templateLeftImage = rgb2gray(imread('TemplateGoalLeft.jpg'));
    goalLeftFeaturePoints = detectSURFFeatures(templateLeftImage);
    [sceneData.goalLeftFeatures, sceneData.goalLeftFeaturePoints] =...
        extractFeatures(templateLeftImage, goalLeftFeaturePoints);
    
    sceneData.goalTemplateFeaturesExtracted = true;
end

%%Left goal corner
try
    %goalLeftBindingStart represents the top left croner of where the
    %search area for the goal posts are
    goalLeftBindingStart = [0 0];
    if ~(sceneData.goalLeftBindingBox == 0)
        if (sceneData.goalLeftFound)
            %Narrow down the search area if the goal posts have been
            %found previously
            x1 = round(sceneData.goalLeftBindingBox(1) -50);
            x2 = round(sceneData.goalLeftBindingBox(1) + sceneData.goalLeftBindingBox(3)+50);
            y1 = round(sceneData.goalLeftBindingBox(2) -50);
            y2 = round(sceneData.goalLeftBindingBox(2) + sceneData.goalLeftBindingBox(4) +50);
            goalLeftBindingStart = round([x1 y1] .* sceneData.cropRatio);
            sceneImageLeft = rgb2gray(InputRGBImg(y1:y2,x1:x2,:));
        else
            sceneImageLeft = rgb2gray(InputRGBImg);
        end
    else
        sceneImageLeft = rgb2gray(InputRGBImg);
    end
    %Extract the features of the scene
    scenePointsLeft = detectSURFFeatures(sceneImageLeft);
    [sceneFeaturesLeft, scenePointsLeft] = extractFeatures(sceneImageLeft, scenePointsLeft);
    
    %Match the features in the scene with the Left goal template
    boxPairsLeft = matchFeatures(sceneData.goalLeftFeatures, sceneFeaturesLeft);
    
    %Retrieve the locations of the corresponding points
    matchedTemplateLeftPoints = sceneData.goalLeftFeaturePoints(boxPairsLeft(:, 1), :);
    matchedScenePoints = scenePointsLeft(boxPairsLeft(:, 2), :);
    [tformLeft, inliertemplatePointsLeft, inlierScenePointsLeft] =...
        estimateGeometricTransform(matchedTemplateLeftPoints, matchedScenePoints, 'affine');
    goalLinesLeft = round(median(inlierScenePointsLeft.Location .* sceneData.cropRatio));
    sceneData.goalLeftFound = true;
catch
    %If there was an error in finding the left goal post
    sceneData.goalLeftFound = false;
end

%%Right goal corner
try
    %goalRightBindingStart represents the top left croner of where the
    %search area for the goal posts are
    goalRightBindingStart = [0 0];
    if ~(sceneData.goalRightBindingBox == 0)
        if (sceneData.goalRightFound)
            %Narrow down the search area if the goal posts have been
            %found previously
            x1 = round(sceneData.goalRightBindingBox(1) -50);
            x2 = round(sceneData.goalRightBindingBox(1) + sceneData.goalRightBindingBox(3)+50);
            y1 = round(sceneData.goalRightBindingBox(2) -50);
            y2 = round(sceneData.goalRightBindingBox(2) + sceneData.goalRightBindingBox(4) +50);
            goalRightBindingStart = round([x1 y1] .* sceneData.cropRatio);
            sceneImageRight = rgb2gray(InputRGBImg(y1:y2,x1:x2,:));
        else
            sceneImageRight = rgb2gray(InputRGBImg);
        end
    else
        sceneImageRight = rgb2gray(InputRGBImg);
    end
    %Extract the features of the scene
    scenePointsRight = detectSURFFeatures(sceneImageRight);
    [sceneFeaturesRight, scenePointsRight] = extractFeatures(sceneImageRight, scenePointsRight);
    
    %Match the features in the scene with the Right goal template
    boxPairsRight = matchFeatures(sceneData.goalRightFeatures, sceneFeaturesRight);
    
    %Retrieve the locations of the corresponding points
    matchedTemplateRightPoints = sceneData.goalRightFeaturePoints(boxPairsRight(:, 1), :);
    matchedScenePoints = scenePointsRight(boxPairsRight(:, 2), :);
    [tformRight, inliertemplatePointsRight, inlierScenePointsRight] =...
        estimateGeometricTransform(matchedTemplateRightPoints, matchedScenePoints, 'affine');
    goalLinesRight = round(median(inlierScenePointsRight.Location .* sceneData.cropRatio));
    sceneData.goalRightFound = true;
catch
    %If there was an error in finding the right goal post
    sceneData.goalRightFound = false;
end

%%Set the output
if (sceneData.goalLeftFound)
    sceneData.goalLines = [[0 0 0 0];[0 0 0 0]];
    sceneData.goalLines(1,:) = [goalLinesLeft(1)+goalLeftBindingStart(1) goalLinesLeft(2)+goalLeftBindingStart(2) goalLinesLeft(1)+goalLeftBindingStart(1) sceneData.fieldBindingBox(2)];
    sceneData.goalLeftBindingBox = [goalLinesLeft(1)+goalLeftBindingStart(1)-30 goalLinesLeft(2)+goalLeftBindingStart(2)-30 60 sceneData.fieldBindingBox(2)-goalLinesLeft(2)+60];    
end
if (sceneData.goalRightFound)
    sceneData.goalLines = [[0 0 0 0];[0 0 0 0]];
    sceneData.goalLines(1,:) = [goalLinesRight(1)+goalRightBindingStart(1) goalLinesRight(2)+goalRightBindingStart(2) goalLinesRight(1)+goalRightBindingStart(1) sceneData.fieldBindingBox(2)];
    sceneData.goalRightBindingBox = [goalLinesRight(1)+goalRightBindingStart(1)-30 goalLinesRight(2)+goalRightBindingStart(2)-30 60 sceneData.fieldBindingBox(2)-goalLinesRight(2)+60];
end
end