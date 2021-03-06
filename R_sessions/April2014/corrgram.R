library(corrgram)

# load nice data and impactpattern, and tags (excluding CrowdSourced)

myData = read.csv("pentaSpeed.csv")


corrData = myData[,c(4,5,6,7,8,13,14,15)]
# corrData

corrMatrix = cor(corrData, use="complete.obs", method="kendall")
#corrMatrix

# .conf .shade .pie .pts .density (?) .ellipse .txt ... diag.panel=panel.density ==> Distribucion de la variable

#pdf(file="PentaWaveAlphas.all.pdf", width=10, height=10)


corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="Pentagon-Wave-Alphas for all")


#corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="correlogram for new tags (29Nov2013)",na.rm= TRUE)

#dev.off()