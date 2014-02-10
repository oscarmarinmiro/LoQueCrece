load("FitPlusFactors.RData")

library(pvclust)

pdf(file="test.pdf", width=10, height=10)

#rownames(components) = paste(components$Company,components$Fit.factor, components$Input,components$Structure,sep = "-")
cluster = pvclust(t(daisy(components[,c(2,3,4)])),method.hclust="ward",method.dist="euclidean",nboot=1000)

#plot(pvclust,cex=0.7,main="Input+Structure+Growth Clustering. Ward Method")

dev.off()
