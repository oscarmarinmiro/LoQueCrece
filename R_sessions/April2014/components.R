
# load nice data and impactpattern, and tags (excluding CrowdSourced)

# http://www.statmethods.net/advstats/factor.html

myData = read.csv("pentaData.csv")

initData = myData

rownames(myData)<-initData[,2]


myData = myData[myData$Era==1,c(5,6,7,8,9,13)]


#results <- princomp(myData, corr=TRUE,na.action=na.omit)
results <- princomp(~.,data=myData, cor = TRUE, na.action=na.omit)

biplot(results, cex=c(0.5, 0.7))

summary(results)
loadings(results)