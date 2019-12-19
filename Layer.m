classdef Layer < handle
    properties
        winningIndex,
        numberOfFilters,
        filterDimension,
        prevDimension,
        layerType, % 1 - Convolutional, 2 - Pooling, 3 - FUlly connected
        activationFunction % 0 - Relu, 1 - Sigmoid, 2 - Softmax
        filters,
        layerOutput,
        error,
        sigma,
        layerInput
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
                    min_element = min(input);
                    input = exp(input-max_element);
                    %             disp(min_element);
                    %             disp(max_element);
                    
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
                        %output(:,:,i) = conv2(input,rot90(layer.filters(:,:,:,i), 2), 'same');
                    case 2
                        [poolingRes, layer.winningIndex] = maxPooling(input, layer.filters(:, :, :, i));
                        output(:,:,i) = poolingRes;
                        %layer.winningIndex = zeros(size(output, 1),size(output, 2),layer.numberOfFilters);
                        %             for l = 1:size(output, 1)
                        %                 for k =1:size(output, 2)
                        %                      layer.winningIndex(l, k) = maxpool_winnner(layer.filters(:, :, :, i), poolingRes(l, k, i));
                        %                 end
                        %             end
                        
                        % TODO: CASE 3
                    case 3
                        input = reshape(input', [1, size(input, 1) * size(input, 2) * size(input, 3)]);
                        % disp(size(input));
                        %disp(size(layer.filters(i, :)));
                        output = fullyConnected(layer.filters, input);
                        break;
                        % disp(size(output))
                    otherwise
                        disp("Please enter correct layer type.")
                end
                i = i - 1;
            end
            layer.layerInput = input;
            %    disp(layer.activation(10))
            if(layer.layerType~=2)
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
            end
            
            layer.layerOutput = output;
        end
        
        function output = calculateError(layer, nextLayer, actualY, prevOutput) %Actual filters
            alpha = 0.1;
            clipBy = 0.5;
            if(layer.layerType==3 && layer.activationFunction == 2)
                %         delF = layer.layerOutput * (1 - layer.layerOutput);
                %delF = (1-layer.layerOutput) * -1;
                
                %         output = (output .* layer.input)) * nextError; % Store the input too
                
                %         output = (1./layer.layerOutput).*actualY * delF; % Check this
                %output = repmat(delF, [1, size(layer.filters, 2)]).*repmat(prevOutput', [size(layer.filters, 1), 1]);
                %output = repmat(actualY, [1,size(layer.filters, 2)]).*output;
                output = layer.layerOutput - actualY;
                output = repmat(output, [1, size(layer.filters, 2)]);
                output = output .* repmat(prevOutput', [size(layer.filters, 1), 1]);
                output = clipValue(output, clipBy);
                layer.filters = layer.filters -  alpha*output; % Refactor to learning rate
                layer.sigma = -actualY.*(1 - layer.layerOutput);
                layer.error = output;
            end
            if(layer.layerType==3 && layer.activationFunction == 0)
                % dE/dwi = dE/dO * dO/dWi
                % dO/dWi = f'(input) * wi - Take input
                % dE/dOl = dE/dOl+1 * dOl+1/dOl
                % dE/dOl = nextError * dOl+1/dOl
                % dOl+1/dOl = summation(weights associated)
                % Ith weight
                output = zeros(size(layer.filters, 1), size(layer.filters, 2));
                for i = 1:size(layer.filters, 1)
                    for j = 1:size(layer.filters, 2)
                        s = nextLayer.filters(:, i)' * nextLayer.sigma * layer.layerInput(1, j);
                        %sum(nextLayer.filters(:, i));
                        output(i, j) = s;
                    end
                end
                
                % Multiply next error here
                %output = output * nextLayer.error; % Check this
                output = clipValue(output, clipBy);
                layer.filters = layer.filters - alpha * output; % Next layer's errors would be an array. What are we multpiplyi8ng by?
                layer.error = output;
            end
            if(layer.layerType==2)
                %Gradient will be routed to the right node.
                % We assign gradients to the previous layer here, since the
                % others would become zero
                % Gradient of neuron vs gradient of weight.
                for i = 1:size(layer.winningIndex, 1)
                    for j = 1:size(layer.winningIndex, 2)
                        x = layer.winningIndex(i, j, 1);
                        y = layer.winningIndex(i, j, 2);
                        z = layer.winningIndex(i, j, 3);
                        onedIndex = (i-1)*size(layer.winningIndex, 2)+j;
                        %                   disp("Coordinates: ");
                        %                   disp(x);
                        %                   disp(y);
                        %                   disp(z);
                        %                   disp(onedIndex);
                        s = sum(nextLayer.error(:, onedIndex));
                        output(x, y, z) = s; %Fix dimensionality
                    end
                end
                
               
                % What ever is connected to it will be routed 
                % The error w.r.t output for prev lay0er would be routed.
                layer.error = output;
            end
            if(layer.layerType ==  1)
                % First calculate Sigma
                % Sigma will be 2D, convolve it with the kth dimension of the
                % previous output
                
                output = zeros(layer.filterDimension,layer.filterDimension,layer.prevDimension,layer.numberOfFilters);
                layer.error = output;
                outputDimensionX = size(layer.layerOutput, 1);
                outputDimensionY = size(layer.layerOutput, 2);
                if(nextLayer.layerType == 2)
                    %CHeck if entering
                    sigma = zeros(outputDimensionX, outputDimensionY, layer.numberOfFilters);
                    for i = 1 : size(nextLayer.winningIndex, 1)
                        for j = 1:size(nextLayer.winningIndex, 2)
                            x = nextLayer.winningIndex(i, j, 1);
                            y = nextLayer.winningIndex(i, j, 2);
                            z = nextLayer.winningIndex(i, j, 3);
                            sigma(x, y, z) = nextLayer.error(x, y, z);
                        end
                    end
                    layer.sigma = sigma;
                else
                    sigma = zeros(outputDimensionX, outputDimensionY, layer.numberOfFilters);
%                     alternateSigma = zeros(outputDimensionX, outputDimensionY, layhe
                    for k = 1 : layer.numberOfFilters
                        l = 0;
                        for nextFilterI = 1:nextLayer.numberOfFilters
                            l = l + convolve(nextLayer.sigma(:,:, nextFilterI), rot90(nextLayer.filters(:, :, k, nextFilterI), 2)); %Vectorize ths
                        end
                        sigma(:, :, k) = l;
                    end
                end
                
                layer.sigma = sigma;
                for k = 1:layer.numberOfFilters
                    for channel = 1:layer.prevDimension
                         alternateError = zeros(size(layer.filters, 1), size(layer.filters, 2));
                         for mt = 1 : size(layer.filters, 1)
                             for nt = 1:size(layer.filters, 2)
                                 s = 0;
                                 p1 = prevOutput(:, :, channel);
                                 p2 = sigma(:, :, k);
                                 for it = 1:size(p2,1)
                                     for jt = 1:size(p2,2)
                                          i1 = it + mt;
                                          j1 = jt + nt;
                                          if i1 <= size(p1, 1) && j1 <= size(p1, 2)
                                              s = s + p1(i1, j1) * p2(it, jt);
                                          end
                                     end
                                 end
                                 alternateError(mt, nt) = s;
                             end
                         end
                        layer.error(:, :, channel, k) = alternateError;
                    end
                end

            layer.error = clipValue(layer.error, clipBy);
            layer.filters = layer.filters - alpha*layer.error;
            end
        end 
    end
    
end

