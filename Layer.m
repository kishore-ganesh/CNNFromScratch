classdef Layer
properties
  winningIndex,
  numberOfFilters,
  filterDimension,
  prevDimension,
  layerType, % 1 - Convolutional, 2 - Pooling, 3 - FUlly connected
  activationFunction %Shoul
end
methods
  function layer = Layer(layerType,numberOfFilters, filterDimension, activationFunction, prevDimension)
    layer.layerType = layerType;
    layer.numberOfFilters = numberOfFilters;
    layer.filterDimension = filterDimension; %Make it robust with optional arguments
    layer.prevDimension = prevDimension;
   end
   function output = Layer(attributesArray)
     %disp(attributesArray);
     m = size(attributesArray)(1)
     output(m) = output
    for i = 1:m
      output(i).layerType = attributesArray(i, 1)
      %output(i).numberOfFilters = attributesArray(i, 2)
    end
   end
  function output = layerFunction(layer, input)
    % call Convolve + Max Pooling Here
    % Add third dimension equal to previous layer dimension 
    % Depending on dimension
    output = zeros(size(input)(1), size(input)(2), layer.numberOfFilters);
    randomFilters = rand(layer.filterDimension,layer.filterDimension,prevDimension, layer.numberOfFilters);
    disp(randomFilters(:, :, :, 1))
    i = layer.numberOfFilters;
    while (i!=0)
      switch layer.layerType
        case 1
          output(:,:,i) = convolve(input, randomFilters(:, :, :, i));
        case 2
          output(:,:,i) = maxPooling(input, randomFilters(:, :, :, i));
        % TODO: CASE 3
        otherwise
          printf("Please enter correct layer type.")
     endswitch
     i = i - 1;
   endwhile
  end
end
end