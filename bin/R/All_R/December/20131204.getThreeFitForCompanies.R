# Read All Metrics in One

myData <- read.csv("All_In_One.v2.csv")

Company <- c()
Fit.p <- c()
Fit.a <- c()
Fit.b <- c()
Pattern.mean <-c()
Fit.factor <-c()
Users <-c()

minP = 0.05

error.companies <-c()

pdf(file="companiesFit.pdf", width=10, height=10)

par(mfcol=c(6,6))
par(omi=c(0,0,0.7,0))
par(mai=c(0.5,0.3,0.3,0.3))
# par(mgp=c(1,0.1,0.1))
par(cex=0.5)

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
		Fit.p = append(Fit.p,ro)
		Fit.a = append(Fit.a,alpha)
		Fit.b = append(Fit.b,beta)
		
		
		avg.impact.pattern = mean(myData[myData$Company==company,c("UsersPattern")], na.rm=TRUE)
		
		usersNum = myData[myData$Company==company & myData$Year=="2012",c("UsersAbsolute")]
		
		Users = append(Users,usersNum)
		
		Pattern.mean = append(Pattern.mean,avg.impact.pattern)
		
		correctFit = normalize.me(alpha,0.07848,0.30660,0.58300,0.86040,2.52400)
		
		Fit.factor = append(Fit.factor,correctFit)
		
		
		print(avg.impact.pattern)
		
		plot(series$ImpactAbsolute~series$Year,type="l",col="red",xlab=sprintf("%s %f   %s %f","Alpha:",alpha,"P:",ro),ylab="Units",main = company)
		lines(exp((series$Year*alpha)+beta)~series$Year,type="l",col="blue",xlab=sprintf("%s %f   %s %f","Alpha:",alpha,"P:",ro),ylab="Units",main = company)

	}
  })
}
mtext("Fitted curves for growth (red=actual,blue=fitted)", outer = TRUE, cex = 1.5)

dev.off()
fitData = data.frame(Company,Fit.p,Fit.a,Fit.b, Pattern.mean, Fit.factor)

cor.test(fitData$Pattern.mean,fitData$Fit.factor)

plot(fitData$Pattern.mean,fitData$Fit.factor)

finalFitData = data.frame(Company,Fit.factor,Fit.a,Users)

# Load final tags

tags = read.csv("factorTags.V2.csv")

# Load founded year

founded = read.csv("launchDate.csv")

# Merge

components = merge(finalFitData,tags)

components = merge(components,founded)

# Clip rubbish

components

# And save

save(components, file="FitPlusFactors.RData")