function [output] = fullyConnected(weights, input) 
    output = weights * transpose(input);
end