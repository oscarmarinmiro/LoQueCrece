# load nice data and impactpattern, and tags (excluding CrowdSourced)
# see http://stat.ethz.ch/R-manual/R-patched/library/stats/html/hclust.html
# method
#the agglomeration method to be used. This should be (an unambiguous abbreviation of) one of "ward", "single", #"complete", "average", "mcquitty", "median" or "centroid".

myData = read.csv("pentaData.csv")


rownames(myData)<-paste(as.character(myData$Company),as.character(myData$Connect),as.character(myData$Collect),as.character(myData$Empower),as.character(myData$Enable),as.character(myData$Share),sep = "-")
myData = myData[,c(5:9)]
myData <- scale(myData)
plot(hclust(dist(myData),method="complete"),cex=0.6, main="PentaClustering: Connect-Collect-Empower-Enable-Share")

# myData <- na.omit(myData)
# myData <- scale(myData)
#fit <- kmeans(myData, 2)

#library(cluster)

#clusplot(myData, fit$cluster, color=TRUE, shade=TRUE, 
#         labels=2, lines=0,cex=0.7)
