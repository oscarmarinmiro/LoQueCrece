# load nice data and just take company,year,impactpattern, and tags (excluding CrowdSourced)

load("componentsPlusFit.RData")
factorData = components

# principal components analysis w/o impactPattern

# compData <- factorData[,]

# principal components analysis w impactPattern

compData <- factorData[,]

fit = princomp(formula = ~., data = compData[,c(2:17)], cor = TRUE, na.action=na.exclude)

summary(fit)
loadings(fit)


pdf(file="biplot.factor.pdf", width=10, height=10)

biplot(fit, choices=1:2, xlabs = compData$Company, main="Component graph for all kinds of growth", cex=c(0.5,0.7))

dev.off()

# Comp1 ==> Centralizado (Service, Breakthrough) vs Distribuido (Platform, Producer,Knowledge)
# Comp2 ==> Tangible (Market,Money,Property,Redistribution) vs Intangible (Media,Knowledge, Platform, Relationships, Commons,BreakThrough)
# Comp3 ==> ???