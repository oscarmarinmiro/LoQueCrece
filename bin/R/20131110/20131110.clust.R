# load nice data and impactpattern, and tags (excluding CrowdSourced)
# see http://stat.ethz.ch/R-manual/R-patched/library/stats/html/hclust.html
# method
#the agglomeration method to be used. This should be (an unambiguous abbreviation of) one of "ward", "single", #"complete", "average", "mcquitty", "median" or "centroid".

myData <- read.csv("niceData.v2.csv")
rownames(myData)<-myData$Company
#clustData = myData[myData$Year == 2012 & !(is.na(myData$ImpactPattern))]
clustData = myData[myData$Year == 2011,]
rownames(clustData) = paste(as.character(clustData$Company),as.character(clustData$Year), sep = "-")
#clustData = myData
finalData = clustData[17:31]
plot(hclust(dist(finalData),method="complete"),cex=0.5, main="Clustering year 2012")
#hclust(clustData,na.rm=TRUE)
