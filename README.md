# CIFAR-10 Dataset for Torch
This is a CIFAR-10 dataset for Torch7. 
It is based on the MNIST Torch Dataset implementation from [andresy/mnist](https://github.com/andresy/mnist).
If you want to know more about the CIFAR-10 dataset, including how to properly cite it in your own work, please refer to [CIFAR-10](https://www.cs.toronto.edu/~kriz/cifar.html).

## Installation ##

torch-rocks install https://raw.github.com/pedropgusmao/cifar10/master/rocks/cifar10-scm-1.rockspec

## Usage ##
```lua
local cifar10	= require 'cifar10'

local trainset	= cifar10.traindataset()
local testset	= cifar10.testdataset()

print(trainset.size) -- to retrieve the size
print(testset.size) -- to retrieve the size
```

Then, the i-th example is retrieved with:
```lua
local ex = trainset[i]
local x = ex.x -- the input (a 3x32x32 ByteTensor)
local y = ex.y -- the label (0--9)
```
