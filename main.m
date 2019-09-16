load('mnist.mat');
dataset = []
%for i = 1:size(trainX)(1)
%dataset = [dataset; deflatten(trainX(i, :))];
%end
dataset = deflatten(trainX(1, :));




