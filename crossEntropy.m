function [output] = crossEntropy(outputs, actualOutputs)
    sum = 0;
   
    for i = 1:size(outputs, 1)
        %disp(actualOutputs(i))
%         disp(outputs(i))
        sum = sum + log(outputs(i, actualOutputs(i)+1)+1e-15);
%           sum = sum + ((outputs(i)-actualOutputs(i))^2);
%           disp(sum);
%         disp(log(outputs(i,actualOutputs(i)+1)));
    end
    output = -sum;
%       output = 0.5*sum;
%     display(output);
end

% For all observations, sum of all errors