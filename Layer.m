classdef Layer
properties
  winningIndex,
  numberOfFilters,
  filterDimension,
  layerType % 1 - Convolutional, 2 - Pooling, 3 - FUlly connected
  activationFunction %Shoul
end
methods
  function layer = Layer(layerType,numberOfFilters, filterDimension, activa)
    layer.layerType = layerType;
    layer.numberOfFilters = numberOfFilters;
    layer.filterDimension = filterDimension; %Make it robust with optional arguments
    
  function output = layerFunction(input)
  end
  
  
end
end
