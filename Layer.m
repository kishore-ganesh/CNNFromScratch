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
  %function layer = Layer(layerType,numberOfFilters, filterDimension, activationFunction, prevDimension)
    %layer.layerType = layerType;
    %layer.numberOfFilters = numberOfFilters;
    %layer.filterDimension = filterDimension; %Make it robust with optional arguments
    %layer.prevDimension = prevDimension;
   %end
   function output = Layer(attributesArray)
     %disp(attributesArray);
     size_attribute_array = size(attributesArray);
     m = size_attribute_array(1)
     output(m) = output
    for i = 1:m
      output(i).layerType = attributesArray(i, 1);
      output(i).numberOfFilters = attributesArray(i, 2);
      output(i).filterDimension = attributesArray(i, 3);
      output(i).activationFunction = attributesArray(i, 4);
      output(i).prevDimension = attributesArray(i, 5);
    end
   end
  function output = layerFunction(layer, input)
    % call Convolve + Max Pooling Here
    % Add third dimension equal to previous layer dimension 
    % Depending on dimension
    size_input = size(input);
    output = zeros(size_input(1), size_input(2), layer.numberOfFilters);
    randomFilters = rand(layer.filterDimension,layer.filterDimension,layer.prevDimension, layer.numberOfFilters);
    disp(randomFilters(:, :, :, 1))
    i = layer.numberOfFilters;
    while (i~=0)
      switch layer.layerType
        case 1
          output(:,:,i) = convolve(input, randomFilters(:, :, :, i));
        case 2
          output(:,:,i) = maxPooling(input, randomFilters(:, :, :, i));
        % TODO: CASE 3
        otherwise
          disp("Please enter correct layer type.")
      end
     i = i - 1;
    end
  end
end
end