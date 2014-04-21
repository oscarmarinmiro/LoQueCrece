
# load nice data and impactpattern, and tags (excluding CrowdSourced)

# http://www.statmethods.net/advstats/factor.html
# v1 = dif ultimo-primero / años
# v2 = dif ultimo-antepenultimo / 1 año
# v3 = v2 normalizado a antepenultimo
# v4 = dif ultimo- primero normalizado / años (si hay mas de dos puntos, se coge el segundo año)

myData = read.csv("pentaSpeedv4.csv")

myData = myData[myData$UserSpeed>10,]

print(myData)
lm.out <- lm(UserSpeed~Empower, data = myData)

#lm.out <- lm(Alpha.Users~Enable, data = myData)
	
print(summary(lm.out))

#cor.test(myData$RevenueSpeed,myData$Enable)