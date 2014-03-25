library(corrgram)

# load nice data and impactpattern, and tags (excluding CrowdSourced)

myData = read.csv("PentagonGrowthClassificationPlus.csv")


corrData = myData[,c(2:12)]
corrData = myData
# corrData

corrMatrix = cor(corrData, use="complete.obs", method="kendall")
#corrMatrix

# .conf .shade .pie .pts .density (?) .ellipse .txt ... diag.panel=panel.density ==> Distribucion de la variable
corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="blah")

#pdf(file="corr.justTags.pdf", width=10, height=10)

#corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="correlogram for new tags (29Nov2013)",na.rm= TRUE)

#dev.off()