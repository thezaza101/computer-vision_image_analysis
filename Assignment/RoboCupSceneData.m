classdef RoboCupSceneData
    %This class cointains the data elements that is required to draw a
    %scene
    
    properties
        cropRatio
        image
        
        ballFound
        
        fieldLines
        goalLines
        
        fieldMask
        ballMask
        
        goalLeftFound
        goalLeftBindingBox
        goalLeftFeaturePoints
        goalLeftFeatures
        
        goalRightFound
        goalRightBindingBox
        goalRightFeaturePoints
        goalRightFeatures
        
        goalTemplateFeaturesExtracted
        
        goalBindingBox
        fieldBindingBox
        ballBindingBox
        
    end
end