function [clusterIdx,Ncut,Level] = myNCutsRecursive(anAffinityMat,T1,T2)
    %%  Description
    
    % Image segmentation using the the recursive version of n-cuts method
    %   Segments the input graph using T1,T2 thresholds.
    
    % Inputs:
    % 1) anAffinityMat : The Aff. Matrix desctribing the graph of the image
    % 2) k             : k-means parameter / Number of clusters forming
    % 3) T1, T2        : Thresholds, values we use to control the recursion
    %                    T2 is for the ncut maximum value
    %                    T1 is for the minimum number of nodes to be
    %                    partitioned
    
    % Outputs
    % 1) clusterIdx    : label showing on which cluster each node belongs
    % 2) ncut          : n-cut values of the cuts of the graph
    % 3) level         : variable to show how the graph was partitioned
    
    %%  Implementation
    
    MN = length(anAffinityMat);
    clustInd = (1:MN)';
    
    %   Steps 1-5 of the non recursive version
    clusterIdx = myNCuts(anAffinityMat,2);              % Initial partition - two clusters
    
    %   Estimation of N-cut vaue
    ncut = calculateNcut(anAffinityMat,clusterIdx);   
    
    %   Starting at first level
    level = 'R';                                        % R for Root of the (unbalanced) tree
    
    %   Positions of clustered pixels
    inA = find(clusterIdx == 1);
    inB = find(clusterIdx == 2);
    
    %   Indices of nodes
    clustIndA = {clustInd(inA)};
    clustIndB = {clustInd(inB)};
    
    %   Number of nodes 
    nA = length(inA);
    nB = length(inB);
    
    % Checking thresholds to continue or stop the algorithm
    if (ncut > T2 || nA < T1 || nB < T1)
        
        % Outputs
        clustInd = {clustIndA{1},clustIndB{1}};
        Level = {[level '-A'],[level '-B']};
        Ncut= {ncut};
        k = length(clustInd);
        
        for i = 1:k
            clusterIdx(clustInd{1,i}) = i;              % Clustering
        end
        
        return
    end
    
    %   Suppress warnings
    warning('off')
    
    %   If the function reaches this point, it moves on to next partition
    
    %   Child A partition
    [nodesA, ncutA, levelA] = PartitionNCuts(clustInd(inA),anAffinityMat(inA,inA),T1,T2,[level '-A']);
    
    %   Child B partition
    [nodesB, ncutB, levelB] = PartitionNCuts(clustInd(inB),anAffinityMat(inB,inB),T1,T2,[level '-B']);
    
    %   Merge
    clustInd = [nodesA nodesB];
    Level = [levelA levelB];
    Ncut = [ncutA ncutB];
    
    %   Preparing output
    k = length(clustInd);
    for i = 1:k
        clusterIdx(clustInd{1,i}) = i;
    end
        
    % Enable warnings again
    warning('on')
end