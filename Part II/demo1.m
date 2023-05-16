%% Demo 1 - Demonstaration of mySpectralClustering.m

%% Clearing

clear all;
close all;
clc;

%%  Import Data

load dip_hw_2.mat

%%  Settings

% Setting seed for for reproducibility  
rng(1)

%%  Clustering

k = 2;
label_2 = mySpectralClustering(d1a,k);
label_2'

k = 3;
label_3 = mySpectralClustering(d1a,k);
label_3'

k = 4;
label_4 = mySpectralClustering(d1a,k);
label_4'

%%  Plots

figure
subplot(2,2,1)
imshow(d1a)
title('Affinity Matrix')

%   Assuming the image that affinity matrix represents is 3*4
subplot(2,2,2)
label_2 = Lab2Im(label_2,3,4);          % Reshape Flip Rotate
imshow(label_2);
title('Clustering, w/ k = 2')

subplot(2,2,3)
label_3 = Lab2Im(label_3,3,4);          % Reshape Flip Rotate
imshow(label_3);
title('Clustering, w/ k = 3')

subplot(2,2,4)
label_4 = Lab2Im(label_4,3,4);          % Reshape Flip Rotate
imshow(label_4);
title('Clustering, w/ k = 4')
