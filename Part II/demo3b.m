%%  Demo 3b - Recursive n-cut demonstration for 1 step

    %    Image segmentation with recursive n-cut for 1 step and comparison with
    %    mySpectralClustering for k = 2.

%%  Clearing

clear all;
close all;
clc;

%%  Import data

load dip_hw_2.mat

%%  Settings

%   Setting seed for for reproducibility 
rng(1)

%   Threshold values:
T1 = 5;
T2 = 0.2;                           % Choosing this value with tria and error to force only one step

%%  Image2Graph

W1 = Image2Graph(d2a);
W2 = Image2Graph(d2b);

%%  Clustering with recursive n-cut / 1 step & Comparison with SC

%   d2a
[label1,Ncut1,Level1] = myNCutsRecursive(W1,T1,T2);
rng(1)
labSC1 = mySpectralClustering(W1,3);

%   d2b
rng(1)
[label2,Ncut2,Level2] = myNCutsRecursive(W2,T1,T2);
labSC2 = mySpectralClustering(W2,3);

%% Comparison on d2a

[M,N,~] = size(d2a);

figure

subplot(2,3,1)
imshow(d2a)
title('Original Image - d2a')

label1 = Lab2Im(label1,M,N);        % Reshape Flip Rotate
subplot(2,3,2)
imshow(label1)
title(['Recursive N-Cuts on d2a w/ 1 Step N-cut value:' num2str(Ncut1{1})])

labSC1 = Lab2Im(labSC1,M,N);        % Reshape Flip Rotate
subplot(2,3,3)
imshow(labSC1)
title('Spectral Clustering on d2a, w/ k = 2')

%%  Comparison on d2b

[M,N,~] = size(d2b);

subplot(2,3,4)
imshow(d2b)
title('Original Image')

label2 = Lab2Im(label2,M,N);        % Reshape Flip Rotate
subplot(2,3,5)
imshow(label2)
title(['Recursive N-Cuts on d2b w/ 1 Step N-cut value:' num2str(Ncut2{1})])

labSC2 = Lab2Im(labSC2,M,N);        % Reshape Flip Rotate
subplot(2,3,6)
imshow(labSC2)
title('Spectral Clustering on d2b, w/ k = 2')