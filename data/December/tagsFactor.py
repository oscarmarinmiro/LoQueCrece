import csv
import pprint

FILE_IN = "tags.V6.csv"
FILE_OUT = "factorTags.V2.csv"


fileIn = open(FILE_IN,"rU")

myReader = csv.reader(fileIn)

tagNames = myReader.next()

companyDict = {}

for row in myReader:

        companyName = row[0]
        description = row[1]

        print companyName

        companyDict[companyName] = []

        for i in range(2,len(row)):
            if row[i]=="1":
                print tagNames[i]
                companyDict[companyName].append(tagNames[i])





#pprint.pprint(companyDict)

fileOut = open(FILE_OUT,"wb")


fileOut.write(",".join(["Company","Input","Structure","Output"])+"\n")

for company in companyDict:
    if len(companyDict[company])>3:
        print "=========\n"+company
        pprint.pprint(companyDict[company])
        print "=========\n"
    fileOut.write(company+","+",".join(companyDict[company][0:3])+"\n")

fileOut.close()