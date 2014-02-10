library(corrgram)

# load nice data and impactpattern, and tags (excluding CrowdSourced)

# ver http://www.statmethods.net/advgraphs/correlograms.html
load("componentsPlusFit.RData")

myData = components
# was corrData = myData[,c(2:17)]

corrData = myData[myData$Fit.factor==4,c(3:17)]
corrData
corrMatrix = cor(corrData, use="complete.obs", method="kendall")
corrMatrix
# .conf .shade .pie .pts .density (?) .ellipse .txt ... diag.panel=panel.density ==> Distribucion de la variable
#corrgram(onlyTags,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="tag Correlation for impact=1", col.regions=colorRampPalette(c("red","salmon","white","royalblue","yellow")))
pdf(file="corr.factor.4.pdf", width=10, height=10)

corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="tag Correlation for alpha=4 model",na.rm= TRUE)

dev.off()

