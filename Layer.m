classdef Layer < handle
properties
  winningIndex,
  numberOfFilters,
  filterDimension,
  prevDimension,
  layerType, % 1 - Convolutional, 2 - Pooling, 3 - FUlly connected
  activationFunction % 0 - Relu, 1 - Sigmoid, 2 - Softmax
  filters,
  layerOutput
end
methods
  %function layer = Layer(layerType,numberOfFilters, filterDimension, activationFunction, prevDimension)
    %layer.layerType = layerType;
    %layer.numberOfFilters = numberOfFilters;
    %layer.filterDimension = filterDimension; %Make it robust with optional arguments
    %layer.prevDimension = prevDimension;
   %end
   function output = Layer(attributesArray)
     if(nargin~=0)
         size_attribute_array = size(attributesArray);
         m = size_attribute_array(1);
         output(m+1) = output;
         for i = 1:m
            output(i).layerType = attributesArray(i, 1);
            output(i).numberOfFilters = attributesArray(i, 2);
            output(i).filterDimension = attributesArray(i, 3);
            output(i).activationFunction = attributesArray(i, 4);
            output(i).prevDimension = attributesArray(i, 5);
            randomFilters = rand(output(i).filterDimension,output(i).filterDimension,output(i).prevDimension, output(i).numberOfFilters);
            if(output(i).layerType==3)
                % Should match input dimensionality
                %randomFilters = rand(output(i).prevDimension, output(i).filterDimension);
                randomFilters = rand(output(i).numberOfFilters, output(i).prevDimension);
            end
            output(i).filters = randomFilters;
            %Handle case for fully connected
         end
     end
   end
   
   function output = activation(layer, input)
    output = 0;
    switch(layer.activationFunction)
        case 0
            if input < 0
                output = 0;
            else 
            output  = input;
            end
        case 1
            % output = 
        case 2
            output = input;
           % disp(input);
           % input = exp(input);
            max_element = max(input);
            min_element = min(input)
            input = exp(input-max_element);
            disp(min_element);
            disp(max_element);
            
            denominator = sum(input);
            
            % disp(size(input))
            for i = 1:size(input, 1)
                output(i) = input(i)/denominator;
            end
            % We expect input to be array
            
            % output = 
            % Softmax: For last layer, output probabilities. Exponential to
            % widen the differences
    end
   end
  function output = layerFunction(layer, input)
    % call Convolve + Max Pooling Here
    % Add third dimension equal to previous layer dimension 
    % Depending on dimension
    size_input = size(input);
    output = zeros(size_input(1), size_input(2), layer.numberOfFilters);
    if layer.layerType == 2
        output = zeros(size_input(1)/2, size_input(2)/2, layer.numberOfFilters);
    end
    
    if layer.layerType == 3
        %disp(size(output))
        output = zeros(layer.numberOfFilters, 1); 
    end
    % disp(randomFilters(:, :, :, 1))
    i = layer.numberOfFilters;    
    
    while (i~=0)
      switch layer.layerType
        case 1
            % disp(size(layer.filters));
            % disp(layer.filters(:, :, :, i))
             output(:,:,i) = convolve(input, layer.filters(:, :, :, i));
              %output(:,:,i) = convn(input,layer.filters(:,:,:,i), 'same');
        case 2
            poolingRes = maxPooling(input, layer.filters(:, :, :, i));
            output(:,:,i) = poolingRes;
            layer.winningIndex = zeros(size(output, 1),size(output, 2),layer.numberOfFilters);
            for l = 1:size(output, 1)
                for k =1:size(output, 2)
                     layer.winningIndex(l, k) = maxpool_winnner(layer.filters(:, :, :, i), poolingRes(l, k, i));
                end
            end
            
        % TODO: CASE 3
        case 3
            input = reshape(input', [1, size(input, 1) * size(input, 2) * size(input, 3)]);
            % disp(size(input));
            %disp(size(layer.filters(i, :)));
            output(i) = fullyConnected(layer.filters(i, :), input);
            % disp(size(output))
        otherwise
          disp("Please enter correct layer type.")
      end
     i = i - 1;
    end
%    disp(layer.activation(10))
     if layer.layerType ~=3 
        for i = 1:size(output, 1)
            for j = 1:size(output, 2)
                for k = 1:size(output, 3)
                  output(i, j, k) = layer.activation(output(i, j, k));
                end
            end
        end
     else
         output = layer.activation(output);
     end
%     layer.layerOutput = output;
  end
  
  function output = calculateError(layer, nextError, actualY, nextWeights, prevOutput) %Actual filters
      if(layer.layerType==3 && layer.activationFunction == 2)
        delF = layer.layerOutput * (1 - layer.layerOutput);
%         output = (output .* layer.input)) * nextError; % Store the input too
        output = (1./layer.layerOutput).*actualY * delF; % Check this
        layer.filters = layer.filters -  0.3*output; % Refactor to learning rate
      end
      if(layer.layerType==3 && layer.activationFunction == 0)
          % dE/dwi = dE/dO * dO/dWi
          % dO/dWi = f'(input) * wi - Take input
          % dE/dOl = dE/dOl+1 * dOl+1/dOl
          % dE/dOl = nextError * dOl+1/dOl
          % dOl+1/dOl = summation(weights associated)
          % Ith weight
          output = zeros(size(layers.filters, 1), size(layers.filters, 2));
          for i = 1:size(layer.filters, 1)
              for j = 1:size(layer.filters, 2)
                  s = sum(nextWeights(:, i)); 
                  output(i, j) = s;
              end
          end
          
          % Multiply next error here
          output = output * nextError; % Check this
          layer.filters = layer.filters - 0.3 * output; % Next layer's errors would be an array. What are we multpiplyi8ng by?
      end
      if(layer.layerType==2)
          %Gradient will be routed to the right node.
          % We assign gradients to the previous layer here, since the
          % others would become zero
          % Gradient of neuron vs gradient of weight.
          output = zeros(layer.filterDimension, layer.filterDimension, layer.prevDimension);
          %output(layer.winningIndex(1), layer.winningIndex(2)) = nextError;
          for i = 1:size(layer.winningIndex, 1)
              for j = 1:size(layer.winningIndex, 2)
                  for k = 1:size(layer.winningIndex, 3)
                  onedIndex = (k-1)*i*j + (i-1)*j + j;
                  s = sum(nextWeights(:, onedIndex));
                  output(i, j, k) = s; %Fix dimensionality
                  end
              end
          end
 
          % Fix winning index
          % This is wrong
          % What ever is connected to it will be routed
          
          % The error w.r.t output for prev layer would be routed.
      end
      if(layer.layerType ==  1)
          % First calculate Sigma
          % Sigma will be 2D, convolve it with the kth dimension of the
          % previous output
          
          output = zeros(layer.filterDimension,layer.filterDimension,layer.prevDimension,layer.numberOfFilters);
          outputDimensionX = size(layer.layerOutput, 1);
          outputDimensionY = size(layer.layerOutput, 2);
          for k = 1 : layer.numberOfFilters
              sigma = zeros(outputDimensionX, outputDimensionY);
              for i = 1:outputDimensionX
                  for j = 1:outputDimensionY
                      for l = 1:size(nextWeights, 4)
                          sigma = sigma + convolve(nextError(:,:,:,l), rot90(nextWeights(:, :, :, l), 2));
                      end
                  end
              end
              for i = 1:layer.filterDimension
                  for j = 1:layer.filterDimension
                      for l = 1:layer.prevDimension
                          convolve(sigma, rot90(prevOutput(:, :, k), 2));
                      end
                  end
              end 
          end
%           output = convolve(nextError,rot90(nextWeights,2));
          %summation along the third dimension
          %Sigma should  be filled along i, j, k
          %
      end
  end
  
%       if(layer.layerType==
          
          % Store max pooling index
end
end
