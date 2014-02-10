# Read All Metrics in One

myData <- read.csv("Growth-V4.csv")

Company <- c()

#CHANGE

rm(Fit.factor)
rm(Fit.a)


Fit.factor <-c()
Fit.a <-c()

minP = 0.05


normalize.me <- function(x,min,first,median,third,max)
{
	if(x>third)
	{
		return(4)
	}
	else
	{
		if (x>median)
		{
			return(3)
		}
		else
		{
			if(x>first)
			{
				return(2)
			}
			else
			{
				return(1)
			}
		}
	}
}

for(company in levels(myData$Company))
{
	print(company)
	#CHANGE
	series <- myData[myData$Company==company,c("Year","RevenueAbsolute")]
	result = try({
	lm.out <- lm(log(series$RevenueAbsolute) ~ series$Year)
	
	# print(company)
	print(summary(lm.out))
	# par(mfrow=c(2,2))
	# plot(lm.out)
	coefs <- summary(lm.out)$coefficients
	# p-value approximated by mean of fourth column
	ro <- mean(coefs[,4])	
	beta <- coefs[1,1]
	alpha <- coefs[2,1]
	print(ro)
	print(beta)
	print(alpha)
	if(ro<=minP)
	{
		Company = append(Company,company)
		Fit.a = append(Fit.a,alpha)
		
		#CHANGE
				
		#correctFit = normalize.me(alpha,0.1309,0.2850,0.5678,0.7422,1.7690)
		
		correctFit = alpha
		
		Fit.factor = append(Fit.factor,correctFit)
		
	}
  })
}
# CHANGE

revenueFit = data.frame(Company,Fit.factor)

names(revenueFit)[names(revenueFit)=="Fit.factor"] <- "Alpha.Revenue"


# And save
#CHANGE
save(revenueFit, file="revenueFit.RData")

summary(Fit.a)