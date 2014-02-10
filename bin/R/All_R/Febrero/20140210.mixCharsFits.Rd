load("allFits.RData")

chars = read.csv("chars-V4.csv")

allData = merge(allFits,chars)

allData <- allData[is.na(d)] <- ""


save(allData, file="allData.RData")

write.csv(allData, file ="allData.csv")