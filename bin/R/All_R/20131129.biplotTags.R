# load nice data and just take company,year,impactpattern, and tags (excluding CrowdSourced)

load("plainTagData.RData")
factorData = onlyTags

# principal components analysis w/o impactPattern

# compData <- factorData[,]

# principal components analysis w impactPattern

compData <- factorData[,]

fit = princomp(formula = ~., data = compData[,c(3:16)], cor = TRUE, na.action=na.exclude)

summary(fit)
loadings(fit)


pdf(file="biplot.onlyTags.pdf", width=10, height=10)

biplot(fit, choices=1:2, xlabs = compData$Company, main="Component graph with new Tags (29Nov2013)", cex=c(0.5,0.7))

dev.off()

# Comp1 ==> Centralizado (Service, Breakthrough) vs Distribuido (Platform, Producer,Knowledge)
# Comp2 ==> Tangible (Market,Money,Property,Redistribution) vs Intangible (Media,Knowledge, Platform, Relationships, Commons,BreakThrough)
# Comp3 ==> ???