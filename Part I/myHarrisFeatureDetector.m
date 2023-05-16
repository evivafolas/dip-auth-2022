function corners = myHarrisFeatureDetector(I)

I = imread('TestIm1.png');
corners = detectHarrisFeatures(I);
figure
hold on
imshow(I);
plot(corners);
hold off

end