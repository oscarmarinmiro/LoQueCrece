
# load nice data and impactpattern, and tags (excluding CrowdSourced)

# http://www.statmethods.net/advstats/factor.html

myData = read.csv("PGC_V2.csv")

myData = myData[myData$Wave==1,]

print(myData)
lm.out <- lm(Alpha.Revenue~Share, data = myData)

#lm.out <- lm(Alpha.Users~Enable, data = myData)
	
print(summary(lm.out))

attach(myData)

cor.test(Alpha.Revenue,Share)