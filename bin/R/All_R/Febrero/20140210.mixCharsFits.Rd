load("allFits.RData")

chars = read.csv("chars-V4.csv")

allData = merge(allFits,chars,all=TRUE)

allData[is.na(allData)] <- ""


save(allData, file="allData.RData")

write.csv(allData, file ="allData.csv")