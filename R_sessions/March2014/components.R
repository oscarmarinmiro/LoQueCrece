
# load nice data and impactpattern, and tags (excluding CrowdSourced)

# http://www.statmethods.net/advstats/factor.html

myData = read.csv("PentagonGrowthClassificationPlus.csv")

myData = myData[,c(2,3,4,5,6,12)]

#results <- princomp(myData, corr=TRUE,na.action=na.omit)
results <- princomp(~.,data=myData, cor = TRUE, na.action=na.omit)

summary(results)
loadings(results)