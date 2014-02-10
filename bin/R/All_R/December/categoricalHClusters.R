library(cluster)

load("FitPlusFactors.RData")

#pdf(file="inputStructureGrowthClustersWard.pdf", width=10, height=10)

rownames(components) = paste(components$Company,components$Fit.factor, components$Public,components$Reward,sep = "-")

plot(hclust(daisy(components[,c(2,3,4,5,6,7)]),method="ward"),cex=0.7,main="Input+Structure+Growth Clustering. Ward Method")

#dev.off()