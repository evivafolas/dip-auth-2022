%% Demo 3a - Demonstration of the Non Recursive version of N-Cuts

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

%% Clustering (N-Cuts) & Visualization

k = 2;
lbla_2 = myNCuts(W1,k);
lblb_2 = myNCuts(W2,k);

k = 3;
lbla_3 = myNCuts(W1,k);
lblb_3 = myNCuts(W2,k);

k = 4;
lbla_4 = myNCuts(W1,k);
lblb_4 = myNCuts(W2,k);

[M,N,~] = size(d2a);

figure
suptitle('N-Cuts on d2a:')

subplot(1,2,1)
imshow(d2a)
title('Original Image')

lbla_2 = Lab2Im(lbla_2,M,N);        % Reshape Flip Rotate
subplot(1,2,2)
imshow(lbla_2)
title('Clustering, w/ k = 2')

figure
suptitle('N-Cuts on d2b:')

subplot(1,2,1)
imshow(d2b)
title('Original Image')

[M,N,~] = size(d2b);

lblb_2 = Lab2Im(lblb_2,M,N);        % Reshape Flip Rotate
subplot(1,2,2)
imshow(lblb_2)
title('Clustering, w/ k = 2')