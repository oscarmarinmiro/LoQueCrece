x <- c(1:6)

pdf(file="alpha_shapes_negative.pdf", width=10, height=10)


for(i in c(-0.5,-1:-6))
{
	alpha = i/4
	print(alpha)
	fun = exp(x*alpha)
	plot(fun~x,type="l",xlab="Year",ylab="ImpactGrowth", yaxt='n',main="Alpha shapes: Negative")
	text = paste("alpha= ",alpha,sep="")
	text(4,exp(4*alpha),text,col="red",cex=0.5)
	par(new=T)	
}

dev.off()