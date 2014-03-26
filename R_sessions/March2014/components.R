
# load nice data and impactpattern, and tags (excluding CrowdSourced)

# http://www.statmethods.net/advstats/factor.html

myData = read.csv("PGC_V2.csv")

initData = myData

myData = myData[myData$Wave==3,c(2,3,4,5,6,9)]

#results <- princomp(myData, corr=TRUE,na.action=na.omit)
results <- princomp(~.,data=myData, cor = TRUE, na.action=na.omit)

biplot(results)

summary(results)
loadings(results)