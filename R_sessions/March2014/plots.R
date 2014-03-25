library(ggplot2)

# load nice data and impactpattern, and tags (excluding CrowdSourced)

myData = read.csv("PentagonGrowthClassificationPlus.csv")

# http://docs.ggplot2.org/0.9.3.1/geom_bar.html

ggplot(myData, aes(x=Wave,fill=factor(Empower))) + geom_bar(stat="bin",position="fill")