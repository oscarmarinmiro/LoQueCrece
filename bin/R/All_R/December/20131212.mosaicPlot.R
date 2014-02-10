library(vcd)

load("FitPlusFactors.RData")

str(components)

#pdf(file="mapFour.pdf", width=10, height=10)

components$Fit.factor <- factor(components$Fit.factor)

#Arthritis$Improved <- ordered(Arthritis$Improved, levels=c("None", "Some", "Marked"))

#ftable(components[,c(3,4,5)])

#mosaic(structable(components[,c(3,4,5)]))

#mosaic(Input~Output+Fit.factor,data=components,shade=TRUE,legend=TRUE,gp=shading_Friendly)

#assoc(formula= ~Input+Output,data=components,shade=TRUE,legend=TRUE,gp=shading_Friendly)

#summary(xtabs(formula = ~Input+Roles,data=components[components$Fit.factor==1,]))

#assoc(formula= Fit.factor+Output~Input,data=components,shade=TRUE,gp=shading_Friendly,cex=2)

assoc(formula= Public~Monetizing,data=components,shade=TRUE,gp=shading_Friendly,labeling_args = list(rot_labels = c(left = 90,top=90,bottom=90,right = 0)),gp_labels=gpar(fontsize=6),offset_labels = c(bottom = 1), margins = c(bottom = 2,right=5))

#dev.off()

