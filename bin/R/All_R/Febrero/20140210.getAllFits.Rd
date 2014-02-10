load("revenueFit.RData")
load("impactFit.RData")
load("usersFit.RData")

mix1 = merge(revenueFit,impactFit, all=TRUE)

allFits = merge(mix1,usersFit,all = TRUE)


save(allFits, file="allFits.RData")