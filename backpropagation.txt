
% calc mean-squared error -> E=1/2 sigma [t(p)-y(p))^2
% update weights according to gradient descent direction of an error
% surface E.
% For backpropagation, two weight updates performed: for the weights and
% for the deltas.


% STEPS
% 1. Transfer derivative
% 2. Error backpropagation


% derivative = output*(1-output);

% OUPUT LAYER:
% error = (actual - output)*derivative(output);

% HIDDEN LAYER:
% error = (weight[i]*error[j])*derivative(output);

% WEIGHT UPDATION:
% weight = weight + alpha*error*input;
