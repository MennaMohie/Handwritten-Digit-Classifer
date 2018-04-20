# data: https://cs.nyu.edu/~roweis/data/mnist_all.mat

data <- R.matlab::readMat("mnist_all.mat");

trains <- list(data[[1]], data[[3]], data[[5]], data[[7]], data[[9]], data[[11]], data[[13]], data[[15]], data[[17]], data[[19]]);
tests  <- list(data[[2]], data[[4]], data[[6]], data[[8]], data[[10]], data[[12]], data[[14]], data[[16]], data[[18]], data[[20]]);

patterns <- sapply(trains,function(x) colMeans(x));
patterns <- matrix(c(patterns), nrow=10, ncol = 784, byrow=TRUE);

correlations = lapply(1:10, function(x) matrix(nrow=nrow(tests[[x]]),ncol=10));
for(i in 1:10)
{
  for(j in 1:10)
  {
    correlations[[i]][,j] = apply(tests[[i]], 1, function(x) cor(x,patterns[j,]))
  }
};

results <- lapply(1:10, function(x) vector(mode="integer",length=nrow(tests[[x]])));
for(i in 1:10)
{
  for(j in 1:nrow(correlations[[i]]))
  {
    results[[i]][j]=which.max(correlations[[i]][j,])-1
  }
};

correct <- 0;
for(i in 1:10)
  correct<- correct + length(which(results[[i]]==(i-1)));
accuracy <- (correct/10000)*100