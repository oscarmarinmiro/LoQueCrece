library(psych)

# load nice data and impactpattern, and tags (excluding CrowdSourced)

# http://www.statmethods.net/advstats/factor.html

myData = read.csv("pentaSpeedv4.csv")

myData = myData[,]


rownames(myData)<-myData[,1]


myData = myData[,c(4,5,6,7,8,13,14,15)]
# 
# 
# #results <- princomp(myData, corr=TRUE,na.action=na.omit)
results <- princomp(~.,data=myData, cor = TRUE, na.action=na.omit)
# 
biplot(results, cex=c(0.5, 0.7))
# 
summary(results)
loadings(results)
# 
# 
# #fit <- principal(myData, nfactors=3, rotate="varimax")

#attach(myData)
#fit <- factanal(~UserSpeed+Empower+Enable+Share, 1, rotation="varimax", na.action=na.exclude)