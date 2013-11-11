library(corrgram)

# load nice data and impactpattern, and tags (excluding CrowdSourced)

# ver http://www.statmethods.net/advgraphs/correlograms.html

myData <- read.csv("niceData.v2.csv")
corrData = myData[myData$ImpactPattern==1,c(17:31)]
corrMatrix = cor(corrData, use="complete.obs", method="kendall")
corrMatrix
# .conf .shade .pie .pts .density (?) .ellipse .txt ... diag.panel=panel.density ==> Distribucion de la variable
#corrgram(onlyTags,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="tag Correlation for impact=1", col.regions=colorRampPalette(c("red","salmon","white","royalblue","yellow")))
corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="tag Correlation for impact=4",na.rm= TRUE)

