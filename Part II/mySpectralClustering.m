function clusterIdx = mySpectralClustering(anAffinityMat,k)
    %%  Description

    % It segments the input graph using the Spectral Clustering
    %   method and returns the labels of the pixels for each cluster.


    % Implementation of Spectral Clustering Method:
    
    % 1. Getting Affinity Matrix
    % 2. Given the Affinity Matrix, calculate the Laplacian Matrix L = D-W
    % 3. Calculating the k smallest eigenvalues and k eigenvectors
    % 4. Creating U matrix with eigenvectors as columns.
    % 5. Grouping with k-means algorithm
    
    % Inputs:
    % 1) anAffinityMat : The Aff. Matrix desctribing the graph of the image
    % 2) k             : k-means parameter / Number of clusters forming
    
    % Outputs
    % 1) clusterIdx    : label showing on which cluster each node belongs

    %%  Implementation
    
    degs = sum(anAffinityMat,2);              % Vector with sum of each row
        
    D = sparse(1:size(anAffinityMat, 1), 1:size(anAffinityMat, 2), degs);
    L = D - anAffinityMat;

    %	Problem of k smallest eigenvalues/eigenvectors
    diff = eps;
    [U,~] = eigs(L,k,diff);                         
            
    %	Grouping with k-means algorithm
    clusterIdx = kmeans(U,k);
        
end