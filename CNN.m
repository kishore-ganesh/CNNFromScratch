classdef CNN
properties
layers = []
end
methods
  function addLayer(CNN, type, numberOfFilters, filterDimension)
    CNN.layers = [CNN.layers; [type, numberOfFilters, filterDimension] ]
  end 
  function constructLayers()
    % CNN.layers = Layers(CNN.layers)
    CNN.layers = Layer([1])
  end
  function output = forwardPropagation(CNN, input)
    prev_output = input
    for i = 1:size(CNN.layers)(2)
      prev_output = CNN.layers(i).layerFunction(prev_output)       
     end
     output = prev_output
  end
end
end
