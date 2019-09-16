classdef CNN
properties
layers = []
end
methods
  function addLayer(type, numberOfFilters, filterDimension)
    layers = [layers, Layer(type, numberOfFilters, filterDimension)]
  end
end
end
