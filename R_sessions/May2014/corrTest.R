library(corrgram)

# load nice data and impactpattern, and tags (excluding CrowdSourced)

myData = read.csv("finalData.csv")


#Access : 3:16 
# Asset: 17:25
# Input: 26:32
# Output: 33:37
# Structure: 38:40
#Pentas: 43:47
# Speeds: 52:54
corrData = myData[,c(33:37,43:47,52:54)]
# corrData

corrMatrix = cor(corrData, use="complete.obs", method="kendall")
#corrMatrix

# .conf .shade .pie .pts .density (?) .ellipse .txt ... diag.panel=panel.density ==> Distribucion de la variable

#pdf(file="PentaWaveAlphas.all.pdf", width=10, height=10)


corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="Pentagon-Wave-Alphas for all")


#corrgram(corrData,lower.panel=panel.shade,upper.panel=panel.conf, diag.panel=panel.density,cex=0.7, main="correlogram for new tags (29Nov2013)",na.rm= TRUE)

#dev.off()