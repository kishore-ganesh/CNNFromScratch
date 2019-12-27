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
layerOneFilters = 8;
layerTwoFilters = 8;
network.addLayer(convolutionL, layerOneFilters, 5, 0, 1, 28*28, layerTwoFilters*layerOneFilters*28*28);
network.addLayer(convolutionL, layerTwoFilters, 5, 0, layerOneFilters,28*28*layerOneFilters, 196*128);
network.addLayer(maxPoolingL, 1, 2, 0, layerTwoFilters,1,1);
network.addLayer(fullyConnectedL, 128, 1, 0, 14*14, 196, 128*10); 
network.addLayer(fullyConnectedL, 10, 1, 2, 128, 128*10, 10); 
network.constructLayers();
numberOfSamples = 100;
output = zeros(numberOfSamples, 10);
input = zeros(28, 28, numberOfSamples);
alpha = 0.3;
%3, 10, 21, 27, 54
% = [trainX(1,:); trainX(3, :); trainX(12,:); trainX(10, :);trainX(36,:); trainX(21, :); trainX(48,:); trainX(27,:)];
%trainY = [trainY(1), trainY(3), trainY(12), trainY(10), trainY(36), trainY(21), trainY(48),trainY(27)];
newTrainX = zeros(100, 784);
newTrainY = zeros(1,100);
index = 1;
for i = 0:9
    k = 1;
       for l = 1:size(trainY, 2)
           if(trainY(1, l)==i)
               newTrainX(index, :) = trainX(l, :);
               newTrainY(1, index) = trainY(l);
               index = index+1;
               k = k+1;
               if(k==11)
                   break;
               end
           end
       end
end

trainX = zeros(100,784);
trainY = zeros(1,100);
newIndex = randperm(100,100);
for i = 1:100
    trainX(i, :) = newTrainX(newIndex(i),:);
    trainY(1, i) = newTrainY(1, newIndex(i));
end
                   
% trainX = newTrainX;
% trainY = newTrainY;

for iterations=1:50000
    numberCorrect = 0;
    for i = 1:numberOfSamples
        sample = trainX(i, :);
        sample = (sample - mean(double(sample)))/std(double(sample));
        sample = deflatten(sample);
        input(:, :, i) = sample;
        output(i, :) = network.forwardPropagation(sample);
        %Check whether transpose
        %network.forwardPropagation(dataset);
        actualOutputIndex = trainY(1, i) + 1;
        actualOutputVector = zeros(10, 1);
%         disp(actualOutputIndex);
        actualOutputVector(actualOutputIndex) = 1;
        if(max(abs(actualOutputVector - output(i,:)')) < 1e-10)
            numberCorrect = numberCorrect + 1;
        end
        
%         network.print()
        network.backwardPropagation(actualOutputVector, input(:,:, i));
    end
  
    %disp(output)
    actualOutput = trainY(1,1:numberOfSamples);
    error = crossEntropy(output, actualOutput);
    disp(error);
    disp("PERC");
    testOutputs = zeros(10,10);
    testCorrect = 0;
    
%     for i=1:numberOfSamples
%         sample = testX(i,:);
%         sample = (sample - mean(double(sample)))/std(double(sample));
%         sample = deflatten(sample);
%          output(i, :) = network.forwardPropagation(sample);
%          actualOutputIndex = testY(1, i) + 1;
%         actualOutputVector = zeros(10, 1);
% %         disp(actualOutputIndex);
%         actualOutputVector(actualOutputIndex) = 1;
%         if(max(abs(actualOutputVector - output(i,:)')) < 1e-10)
%             testCorrect = testCorrect+1;
%         end
%         
%     end
    %disp(double(testCorrect)/numberOfSamples);
                                      disp(1-double(numberCorrect)/numberOfSamples);
%     network.backwardPropagation(actualOutputVector, input(:,:, i));
end

% Batch or not?
% Manually verify forward propagation
% Remove size matrix and correct it
% Normalization of weights before doing anything

%Error for fully connected similar to regular network. Once we have this
%value, we back propagate throguh convolution bp

% Vectorize the input
% Shouold automate this calculation
% Begin backpropagation 
% Cross verify the large values
% Derivative: s(j) * (1-s(j))

% In each epoch. We need to forward propagate. Then calculate errors. Now,
% we find error matrix for each layer. There will be k error matrices for
% each layer, where k is the number of filters in that layer. We would need
% to store these error matrices for calculating the previous layer's errors.
% Once the error is calculated, we multiply the error matrix by the
% learning rate, and then add to the weight matrix.
