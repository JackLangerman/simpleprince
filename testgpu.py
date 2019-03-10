import sys

print(sys.version)


import tensorflow as tf
print("Tensorflow Version:", tf.__version__)
print("\nTensorflow knows about GPU: ", tf.test.is_gpu_available(), "\n\n")


import torch
print("PyTorch Version:", tf.__version__)
print("\nPyTorch knows about GPU: ", tf.test.is_gpu_available(), "\n\n")


import keras 
from keras import backend as K
print("Keras Version:", keras.__version__)
print("\nKeras knows about GPU: ", len(K.tensorflow_backend._get_available_gpus())>0, "\n\n")
