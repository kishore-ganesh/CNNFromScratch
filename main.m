load('mnist.mat');
dataset = [];
%for i = 1:size(trainX)(1)
%dataset = [dataset; deflatten(trainX(i, :))];
%end
dataset = deflatten(trainX(1, :));
network = CNN;
convolutionL = 1;
maxPoolingL = 2;
fullyConnectedL = 3;
% Layer type, number of filters, filter dimension, activationFunction,
% prevDimension
network.addLayer(convolutionL, 32, 3, 0, 1);
network.addLayer(convolutionL, 64, 3, 0, 32);
network.addLayer(maxPoolingL, 1, 2, 0, 64);
network.addLayer(fullyConnectedL, 128, 1, 0, 14*14); 
network.addLayer(fullyConnectedL, 10, 1, 2, 128); 
network.constructLayers();
numberOfSamples = 10;
output = zeros(numberOfSamples, 10);
input = zeros(28, 28, numberOfSamples);
alpha = 0.3;
for iterations=1:2
    for i = 1:numberOfSamples
        sample = trainX(i, :);
        sample = double(sample)/2550;
        sample = deflatten(sample);
        input(:, :, i) = sample;
        output(i, :) = network.forwardPropagation(sample);
        %Check whether transpose
        %network.forwardPropagation(dataset);
        actualOutputIndex = testY(1, i) + 1;
        actualOutputVector = zeros(10, 1);
        disp(actualOutputIndex);
        actualOutputVector(actualOutputIndex) = 1;
        
%         network.print()
        network.backwardPropagation(actualOutputVector, input(:,:, i));
    end
    actualOutputIndex = testY(1, 1);
    actualOutputVector = zeros(10, 1);
    actualOutputVector(actualOutputIndex) = 1;
    actualOutput = testY(1,1:numberOfSamples);
    
    error = crossEntropy(output, actualOutput);
    disp(error);
%     network.backwardPropagation(actualOutputVector, input(:,:, i));
end

% Backpropagation for each erorr?
% Batch or not?
%Auto initialization of output
% Manually verify forward propagation
% Add fully connected layer
% Remove size matrix and correct it
% Normalization of weights before doing anything

%Error for fully connected similar to regular network. Once we have this
%value, we back propagate throguh convolution bp

% Vectorize the input
% Shouold automate this calculation
% Softmax is exponential wtf - Still not solved
% Begin backpropagation 
% Cross verify the large values
% Derivative: s(j) * (1-s(j))

% In each epoch. We need to forward propagate. Then calculate errors. Now,
% we find error matrix for each layer. There will be k error matrices for
% each layer, where k is the number of filters in that layer. We would need
% to store these error matrices for calculating the previous layer's errors.
% Once the error is calculated, we multiply the error matrix by the
% learning rate, and then add to the weight matrix.

% Use the inbuilt index function to calculate index

% Add max poool index function

% Check why that weird thing was happening