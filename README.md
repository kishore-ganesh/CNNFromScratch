# CNN
Convolutional Neural Network from scratch in Matlab

In order to understand how Convolutional Neural Networks work, we've built a convolutional neural network from scratch in Matlab,
using barebones Matrix operations to realize this vision.

## Architecture
We're using the MNIST dataset (the Hello World dataset of Machine Learning) to evaluate our CNN. Our CNN consists of:
1. Convolution Layer (32 filters) - Relu
2. Convolution Layer (64 filters) - Relu
3. Max Pooling Layer 
4. Fully Connected Layer (128 nodes) - Relu
5. Fully Connected Layer (10 nodes) - Softmax (Stable Version)

The loss function being used is Categorical Cross Entropy.


We're using the stochachistic gradient descent algorithm with fixed learning rate and gradient clipping to train the Neural Network.

On small samples it is giving promising results, however the effectiveness of the CNN can't be commented on right now since we're evaluating its performance
and accuracy since it is taking a long time to train, in no small part due to the code not being vectorized in some places and since we only have a CPU at our disposal.



## References:
We used the following references in order to derive the equations and adapt them as per our needs.

### [Jefkines - Derivation of Backpropagation for CNN](https://www.jefkine.com/general/2016/09/05/backpropagation-in-convolutional-neural-networks/)
### [Eli the Green Place - Softmax Derivative](https://eli.thegreenplace.net/2016/the-softmax-function-and-its-derivative/)
### [StackExchange Max Pooling Question](https://datascience.stackexchange.com/questions/11699/backprop-through-max-pooling-layers)
### [Keras Documentation](https://keras.io/examples/mnist_cnn/) (Used for deciding Architecture)
### [Gradient Clipping - Machine Learning Mastery](https://machinelearningmastery.com/how-to-avoid-exploding-gradients-in-neural-networks-with-gradient-clipping/)
### [Andrew NG - Convolutional Neural Networks](https://www.coursera.org/learn/convolutional-neural-networks/home/welcome)
