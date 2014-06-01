accessData = read.csv("Access.csv")
assetData = read.csv("Asset.csv")
inputData = read.csv("Input.csv")
outputData = read.csv("Output.csv")
structureData = read.csv("Structure.csv")

pentaSpeed = read.csv("pentaSpeedv2.csv")

mix1 = merge(accessData,assetData)

mix2 = merge(mix1, inputData)

mix3 = merge(mix2, outputData)

mix4 = merge(mix3, structureData)

finalData = merge(mix4, pentaSpeed)

write.csv(finalData, file = "finalData.csv")
