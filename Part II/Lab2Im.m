function lab = Lab2Im(label,M,N)

    %   Helper function for transforming (Reshape-Flip-Rotate) the clustered
    %       indiced to form the new clustered image

    label = label/max(label);
    label = reshape(label,[M N]);
    lab = label';
    
end