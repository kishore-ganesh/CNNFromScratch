function output = clipValue(inputMatrix, clip)
    output = zeros(size(inputMatrix, 1), size(inputMatrix, 2), size(inputMatrix, 3), size(inputMatrix, 4));
    for i = 1:size(inputMatrix, 1)
        for j = 1:size(inputMatrix, 2)
            for k = 1:size(inputMatrix, 3)
                for l = 1:size(inputMatrix, 4)
                    output(i,j,k,l) = inputMatrix(i,j,k,l);
                    if(inputMatrix(i, j, k, l) > clip)
                        output(i,j,k,l) = clip;
                    end
                    
                    if(inputMatrix(i,j,k,l) < -clip)
                        output(i,j,k,l) = - clip;
                    end
                end
            end
        end
    end
end
