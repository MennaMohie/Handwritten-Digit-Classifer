data <- R.matlab::readMat("mnist_all.mat")
patterns <- sapply(data,function(x) colMeans(x))