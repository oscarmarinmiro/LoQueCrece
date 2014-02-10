# Read All Metrics in One

library(plyr)

myData <- read.csv("Growth-V4.csv")

Company <- c()

#CHANGE

Fit.factor <-c()
Fit.a <-()

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
	series <- myData[myData$Company==company,c("Year","UsersAbsolute")]
	result = try({
	lm.out <- lm(log(series$UsersAbsolute) ~ series$Year)
	
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
				
		#correctFit = normalize.me(alpha,0.07848,0.38440,0.59250,0.98460,4.16100)
		
		correctFit = alpha
		
		Fit.factor = append(Fit.factor,correctFit)
		
	}
  })
}
# CHANGE

usersFit = data.frame(Company,Fit.factor)

names(usersFit)[names(usersFit)=="Fit.factor"] <- "Alpha.Users"


# And save
#CHANGE
save(usersFit, file="usersFit.RData")

summary(Fit.a)