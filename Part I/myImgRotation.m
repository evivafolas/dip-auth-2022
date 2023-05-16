function imgRot = myImgRotation(img, angle)

% I = imread('TestIm1.png');
% imshow(I);

I = imread(img);

imgRot = imrotate(I,angle,'bilinear');
% imshow(imgRot);

% imwrite(imgRot,'imgageRotated2.png');

end