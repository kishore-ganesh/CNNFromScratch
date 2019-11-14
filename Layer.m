
classdef Layer
properties
  winningIndex,
  numberOfFilters,
  filterDimension,
  layerType, % 1 - Convolutional, 2 - Pooling, 3 - FUlly connected
  activationFunction %Shoul
end
methods
  function layer = Layer(layerType,numberOfFilters, filterDimension, activationFunction)
    layer.layerType = layerType;
    layer.numberOfFilters = numberOfFilters;
    layer.filterDimension = filterDimension; %Make it robust with optional arguments
   end
  function output = layerFunction(layer, input)
    % call Convolve + Max Pooling Here
    % Add third dimension equal to previous layer dimension 
    %randomFilters = rand(layer.filterDimension,layer.filterDimension,layer.numberOfFilters)
    %randomFilters(10, 10, 10)
    %i = layer.numberOfFilters
    %while (i!=0)
      %switch layer.layerType
        %case 1
         % output(:,:,i) = convolve(input, randomFilters(:,:,i))
        %case 2
        %  output(:,:,i) = maxPooling(input, random(:,:,i))
        % TODO: CASE 3
       % otherwise
      %    printf("Please enter correct layer type.")
     % endswitch
    %  i = i - 1
   % endwhile
  end
end
end