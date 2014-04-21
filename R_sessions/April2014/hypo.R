library(corrgram)

# load nice data and impactpattern, and tags (excluding CrowdSourced)

myData = read.csv("pentaData.csv")


corrData = myData[myData$Era==3,c(4:13)]
# corrData

corrMatrix = cor(corrData, use="complete.obs", method="kendall")
#corrMatrix

# .conf .shade .pie .pts .density (?) .ellipse .txt ... diag.panel=panel.density ==> Distribucion de la variable

#pdf(file="PentaWaveAlphas.all.pdf", width=10, height=10)


corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="Pentagon-Wave-Alphas for all")


#corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="correlogram for new tags (29Nov2013)",na.rm= TRUE)

#dev.off()