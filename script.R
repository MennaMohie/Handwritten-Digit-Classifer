data <- R.matlab::readMat("mnist_all.mat");

tests <- list(data[[2]],data[[4]],data[[6]],data[[8]],
              data[[10]],data[[12]],data[[14]],data[[16]],data[[18]],data[[20]]);

patterns <- sapply(data,function(x) colMeans(x));
patterns <- matrix(
  c(patterns[,1],patterns[,3],patterns[,5],patterns[,7],patterns[,9],
    patterns[,11],patterns[,11],patterns[,13],patterns[,15],patterns[,17]),
  nrow=10, ncol = 784, byrow=TRUE
);

correlations = lapply(1:10, function(x) matrix(nrow=nrow(tests[[x]]),ncol=10));
for(i in 1:10)
{
  for(j in 1:10)
  {
    correlations[[i]][,j] = apply(tests[[i]],1,function(x) cor(x,zero[j,]))
  }
};

results <- lapply(1:10, function(x) vector(mode="integer",length=nrow(tests[[x]])));
for(i in 1:10)
{
  for(j in 1:nrow(corr[[i]]))
  {
    results[[i]][j]=which.max(corr[[i]][j,])-1
  }
};

correct <- 0;
for(i in 1:10)
  correct<- correct + length(which(results[[i]]==(i-1)));
accuracy <- (correct/10000)*100;
accuracy