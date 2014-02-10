# load nice data and just take company,year,impactpattern, and tags (excluding CrowdSourced)

myData <- read.csv("niceData.v2.csv")
factorData = myData[c(2:3,7,17:31)]

# principal components analysis w/o impactPattern

#compData <- factorData[,]

# principal components analysis w impactPattern

compData <- factorData[compData$ImpactPattern==4,]

fit = princomp(formula = ~., data = compData[,c(4:18)], cor = TRUE, na.action=na.exclude)

summary(fit)
loadings(fit)



biplot(fit, choices=1:2, xlabs = compData$Company, main="OOO", cex=c(0.5,0.7))

# Comp1 ==> Centralizado (Service, Breakthrough) vs Distribuido (Platform, Producer,Knowledge)
# Comp2 ==> Tangible (Market,Money,Property,Redistribution) vs Intangible (Media,Knowledge, Platform, Relationships, Commons,BreakThrough)
# Comp3 ==> ???


