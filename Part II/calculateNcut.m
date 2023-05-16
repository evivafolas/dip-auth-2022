function nCutValue = calculateNcut(anAffinityMat, clusterIdx)
    %%  Description 
    
    % Describes the metric Ncut(A,B) = 2 - Nassoc(A,B)
    %   where Nassoc(A,B) = assoc(A,A)/assoc(A,V) + assoc(B,B)/assoc(B,V) 
    %   and assoc(A,V) is the sum of all the weights of nodes of A / weights
    %   of nodes of V

    % Inputs:
    % 1) anAffinityMat : The Aff. Matrix desctribing the graph of the image
    % 2) clusterIdx    : label that shows on which of the 2 clusters the
    %                    node belonds
 
    % Outputs:
    % 1) nCutValue     : holds the value of the metric for the 2 node
    %                    groups
    
    %%  Implementation
    
    lblWith1 = clusterIdx == 1;        % Indices of nodes of 1st cluster
    
    assocA_A = sum(sum(anAffinityMat(lblWith1,lblWith1)));
    assocA_V = sum(sum(anAffinityMat(lblWith1,:)));
    
    lblWith2 = ~lblWith1;              % Indices of nodes of 2nd cluster
    
    assocB_B = sum(sum(anAffinityMat(lblWith2,lblWith2)));
    assocB_V = sum(sum(anAffinityMat(lblWith2,:)));
    
    %   Calculating Nassoc;
    Nassoc = assocA_A/assocA_V+assocB_B/assocB_V;
    
    %   Result
    nCutValue = 2 - Nassoc;
    
end