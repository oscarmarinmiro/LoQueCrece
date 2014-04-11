library(ggplot2)

# load nice data and impactpattern, and tags (excluding CrowdSourced)

myData = read.csv("pentaData.csv")

# http://docs.ggplot2.org/0.9.3.1/geom_bar.html

# First type: Vertical histograms per era
ggplot(myData, aes(x=Era,fill=factor(Collect))) + geom_bar(stat="bin",position="stack",binwidth = 0.5)

#ggplot(myData, aes(x=Era,fill=factor(Collect))) + geom_bar(stat="bin",position="fill",binwidth = 0.5)


# Second type: Dispersion w/ color by era
ggplot(myData, aes(x=Collect,y=Avg.Alpha,color=factor(Era))) + geom_point()

#ggplot(myData, aes(x=Collect, y=Connect,fill=Era)) + geom_bar(stat="identity")

