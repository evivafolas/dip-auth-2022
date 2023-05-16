%% Demo 2 - Demonstration of Image2Graph.m and mySpectralClustering.m

% Image segmentation with spectral clustering / k-means

%% Clearing

clear all;
close all;
clc;

%% Import data
load dip_hw_2.mat

%% Settings
% Setting seed for for reproducibility 
rng(1)

%% Image2Graph

W1 = Image2Graph(d2a);
W2 = Image2Graph(d2b);

%% Clustering (k-means) & Visualization

k = 2;
lbla_2 = mySpectralClustering(W1,k);
lblb_2 = mySpectralClustering(W2,k);

k = 3;
lbla_3 = mySpectralClustering(W1,k);
lblb_3 = mySpectralClustering(W2,k);

k = 4;
lbla_4 = mySpectralClustering(W1,k);
lblb_4 = mySpectralClustering(W2,k);

[M,N,~] = size(d2a);

figure
suptitle('mySpectralClustering on d2a:')

subplot(2,2,1)
imshow(d2a)
title('Original Image')

lbla_2 = Lab2Im(lbla_2,M,N);        % Reshape Flip Rotate
subplot(2,2,2)
imshow(lbla_2)
title('Clustering, w/ k = 2')

lbla_3 = Lab2Im(lbla_3,M,N);        % Reshape Flip Rotate
subplot(2,2,3)
imshow(lbla_3)
title('Clustering, w/ k = 3')

lbla_4 = Lab2Im(lbla_4,M,N);        % Reshape Flip Rotate
subplot(2,2,4)
imshow(lbla_4)
title('Clustering, w/ k = 4')

figure
suptitle('mySpectralClustering on d2b:')

subplot(2,2,1)
imshow(d2b)
title('Original Image')

[M,N,~] = size(d2b);

lblb_2 = Lab2Im(lblb_2,M,N);        % Reshape Flip Rotate
subplot(2,2,2)
imshow(lblb_2)
title('Clustering, w/ k = = 2')

lblb_3 = Lab2Im(lblb_3,M,N);        % Reshape Flip Rotate
subplot(2,2,3)
imshow(lblb_3)
title('Clustering, w/ k = 3')

lblb_4 = Lab2Im(lblb_4,M,N);        % Reshape Flip Rotate
subplot(2,2,4)
imshow(lblb_4)
title('Clustering, w/ k = 4')