function myLocalDescriptorUpgrade(I,angle)

imCol = imread(I);
I2col = myImgRotation(I,angle);

%%

I = rgb2gray(imCol);
% imageSegmenter(I)
I2 = rgb2gray(I2col);
% imageSegmenter(I2)

%%

ptsI  = detectSURFFeatures(I);
ptsI2 = detectSURFFeatures(I2);
[featuresI,validPtsI] = extractFeatures(I,ptsI);
[featuresI2,validPtsI2] = extractFeatures(I2,ptsI2);

index_pairs = matchFeatures(featuresI,featuresI2);
matchedPtsI  = validPtsI(index_pairs(:,1));
matchedPtsI2 = validPtsI2(index_pairs(:,2));
figure 
showMatchedFeatures(I, I2, matchedPtsI, matchedPtsI2)
title('Matched SURF Points With Outliers');

%%
% [tform,inlierIdx] = estimateGeometricTransform2D(matchedPtsI2, matchedPtsI, 'similarity');
% inlierPtsI2 = matchedPtsI2(inlierIdx,:);
% inlierPtsI  = matchedPtsI(inlierIdx,:);
% 
% figure 
% showMatchedFeatures(I,I2,inlierPtsI,inlierPtsI2)
% title('Matched Inlier Points')

tform = estimateGeometricTransform(matchedPtsI2, matchedPtsI, 'similarity');

%%
outputView = imref2d(size(I));
Ir = imwarp(I2,tform,'OutputView',outputView);
figure 
imshow(Ir); 
title('Recovered Image');
end
