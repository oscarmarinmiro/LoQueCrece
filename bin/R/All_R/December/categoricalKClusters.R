library(fpc)
load("FitPlusFactors.RData")

pdf(file="KClusters.pdf", width=10, height=10)

rownames(components) = paste(components$Company,components$Fit.factor, components$Input,components$Structure,sep = "-")

dissimData = daisy(components[,c(3,4)])

cluster <- kmeans(dissimData,20)

# to derive the optimum number of clusters. 9 w/o growth, 3 w/growth
#cluster <- pamk(dissimData)

clusplot(components, cluster$cluster,color=TRUE, 
   	 labels=2,lines=0,cex=0.5)

dev.off()