function myAffinityMat = Image2Graph(imIn)

    %   Getting image size/dimensions
    M = size(imIn,1);
    N = size(imIn,2);
    n = size(imIn,3);
    
    imIn = double(imIn);
    
    %   Initialize affinity matrix
    myAffinityMat = zeros(M*N);
    
    %   Pixel i coordinates
    for xi = 1:M
        for yi = 1:N
            
    %   Pixel j coordinates
            for xj = 1:M
                for yj = 1:N
                    
    %   Pixels notation for comparison
                    i = (xi-1)*M + yi;
                    j = (xj-1)*M + yj;
                    
    %   Given that myAffinityMat is going to be symmetric,
    %       we pass for speed purposes
                   if i > j 
                       continue 
                   end
                   
    %   Calculating the euclidian distance between rgb pixels:
                   d = 0;
                   
                   for k = 1:n
                       
                       d = d + ( imIn(xi,yi,k) - imIn(xj,yj,k) )^2;
                   
                   end
                   
                   d = sqrt(d);
                   
    %   Metric given:
                   myAffinityMat(i,j) = exp(-d);     
                   
    %   Symmetry
                   myAffinityMat(j,i) = myAffinityMat(i,j); 
                   
                end 
            end
        end 
    end
end