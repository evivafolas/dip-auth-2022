function myStitch(stitch)

scene = imageDatastore(stitch);
montage(scene.Files)

%%
% Read the first image from the image set.
I = readimage(scene,1);

% Initialize features for I(1)
gray1 = rgb2gray(I);
points = detectSURFFeatures(gray1);
[features, points] = extractFeatures(gray1,points);

tforms(2) = projective2d(eye(3));
imageSize = zeros(2,2);

I2 = readimage(scene,2);
gray2 = rgb2gray(I2);
imageSize(2,:) = size(gray2);

% Detect and extract SURF features for I(n).
points2 = detectSURFFeatures(gray2);    
[features2, points2] = extractFeatures(gray2, points2);
% Find correspondences between I(n) and I(n-1).
indexPairs = matchFeatures(features2, features, 'Unique', true);


matchedPoints2  = points2(indexPairs(:,1), :);
matchedPoints   = points(indexPairs(:,2), :);

tforms(2) = estimateGeometricTransform(matchedPoints2, matchedPoints, 'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);

tforms(2).T = tforms(2).T * tforms(1).T;

%%

for i = 1:numel(tforms)           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);    
end

avgXLim = mean(xlim, 2);
[~,idx] = sort(avgXLim);
centerIdx = floor((numel(tforms)+1)/2);
centerImageIdx = idx(centerIdx);

Tinv = invert(tforms(centerImageIdx));
for i = 1:numel(tforms)    
    tforms(i).T = tforms(i).T * Tinv.T;
end

%%

for i = 1:numel(tforms)           
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(i,2)], [1 imageSize(i,1)]);
end

maxImageSize = max(imageSize);

% Find the minimum and maximum output limits. 
xMin = min([1; xlim(:)]);
xMax = max([maxImageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([maxImageSize(1); ylim(:)]);

% Width and height of panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);

% Initialize the "empty" panorama.
panorama = zeros([height width 3], 'like', I);


%% Creating the Image Stitch

blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');  

% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);

% Create the panorama.
for i = 1:2
    
    I = readimage(scene, i);   
   
    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);
                  
    % Generate a binary mask.    
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);
    
    % Overlay the warpedImage onto the panorama.
    panorama = step(blender, panorama, warpedImage, mask);
end

figure
imshow(panorama)
end
















