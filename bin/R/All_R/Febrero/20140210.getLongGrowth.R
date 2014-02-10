library(ggplot2)

fullGrowth <- read.csv("Full_Growth.csv")

minP = 0.05

window = 3

dataPoints = 17

company = "Facebook"

type = "Users"

growth <- fullGrowth[fullGrowth$Company == company & fullGrowth$Type==type,]

print(growth)

Alpha <-c()
Ro <-c()
Year <-c()

for(i in 1:(dataPoints-window+1))
{
	nowGrowth = growth[growth$Year >= i & growth$Year<i+window,]
	
	# print(i);
	# print(nowGrowth);
	
	lm.out <- lm(log(nowGrowth$Data) ~ nowGrowth$RealYear)
	
	coefs <- summary(lm.out)$coefficients

	# p-value approximated by mean of fourth column
	ro <- mean(coefs[,4])	
	beta <- coefs[1,1]
	alpha <- coefs[2,1]

	print("===========")
	print("Year")
	print(i)
	print(alpha)
	print(ro)
	print("===========")
	
	
	
	Year = append(Year,nowGrowth$RealYear[0:1]+1)
	Alpha = append(Alpha,alpha)
	Ro = append(Ro,ro)

}

alphaYears = data.frame(Year,Alpha,Ro)

ggplot(alphaYears, aes(x=Year, y=Alpha)) + geom_line() + ggtitle(paste(company,type))

