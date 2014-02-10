# load nice data and impactpattern, and tags (excluding CrowdSourced)
# see http://stat.ethz.ch/R-manual/R-patched/library/stats/html/hclust.html
# method
#the agglomeration method to be used. This should be (an unambiguous abbreviation of) one of "ward", "single", #"complete", "average", "mcquitty", "median" or "centroid".

load("componentsPlusFit.RData")

myData = components

rownames(myData)<-myData$Company
#clustData = myData[myData$Year == 2012 & !(is.na(myData$ImpactPattern))]
#clustData = myData[myData$Year == 2011,]
clustData = myData[myData$Fit.factor==4,]
rownames(clustData) = paste(as.character(clustData$Company),as.character(clustData$Fit.factor), sep = "-")
#clustData = myData
#was 2:17, LOOKOUT!!
finalData = clustData[3:17]
pdf(file="clust.factor.4.pdf", width=10, height=10)
plot(hclust(dist(finalData),method="complete"),cex=0.5, main="Clustering alpha=4. Number is alpha growth factor")
dev.off()
#hclust(clustData,na.rm=TRUE)
