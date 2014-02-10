
timeFit = read.csv("timeFit.csv")
Evernote = timeFit[timeFit$Company=="Evernote",c(2,4)]
lm.out = lm(log(Evernote$Units) ~ Evernote$Year)
lm.out