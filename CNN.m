classdef CNN < handle
properties
layers = []
end
methods
    function addLayer(CNN, type, numberOfFilters, filterDimension, activationFunction, prevDimension)
    CNN.layers = [CNN.layers; [type, numberOfFilters, filterDimension, activationFunction, prevDimension] ]
  end 
  function constructLayers(CNN)
    % CNN.layers = Layers(CNN.layers)
    disp(CNN.layers);
    CNN.layers = Layer(CNN.layers);
  end
  function output = forwardPropagation(CNN, input)
    prev_output = input;
    size_cnn_layers = size(CNN.layers);
    for i = 1:size_cnn_layers(2)
      prev_output = CNN.layers(i).layerFunction(prev_output);       
     end
     output = prev_output;
  end
end
end
