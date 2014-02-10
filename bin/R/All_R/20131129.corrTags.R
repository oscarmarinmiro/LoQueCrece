library(corrgram)

# load nice data and impactpattern, and tags (excluding CrowdSourced)

# ver http://www.statmethods.net/advgraphs/correlograms.html
load("plainTagData.RData")

myData = onlyTags

# was corrData = myData[,c(2:17)]

corrData = myData[,c(3:16)]
# corrData
corrMatrix = cor(corrData, use="complete.obs", method="kendall")
corrMatrix
# .conf .shade .pie .pts .density (?) .ellipse .txt ... diag.panel=panel.density ==> Distribucion de la variable
# corrgram(onlyTags,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="tag Correlation for impact=1", col.regions=colorRampPalette(c("red","salmon","white","royalblue","yellow")))

pdf(file="corr.justTags.pdf", width=10, height=10)

corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="correlogram for new tags (29Nov2013)",na.rm= TRUE)

dev.off()

