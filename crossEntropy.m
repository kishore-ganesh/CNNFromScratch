function [output] = crossEntropy(outputs, actualOutputs)
    sum = 0;
   
    for i = 1:size(outputs, 1)
        %disp(actualOutputs(i))
%         disp(outputs(i))
        sum = sum + log(outputs(i, actualOutputs(i)+1)+1e-15);
    end
    output = -sum;
end

% For all observations, sum of all errors