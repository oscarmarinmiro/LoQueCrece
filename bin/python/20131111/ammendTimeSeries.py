__author__ = 'oscarmarinmiro'

import csv
import pprint


MIN_POINTS = 4

FILE_NAME = "timeDataPython.csv"

fileIn = open(FILE_NAME,"rU")

reader = csv.reader(fileIn)

header = reader.next()

companyDict = {}

# For each company

for row in reader:

    myCompany = row[1]
    myYear = int(row[2])
    myNumber = row[3]

    if myCompany not in companyDict:
        companyDict[myCompany] = {2008:0,2009:0,2010:0,2011:0,2012:0,2013:0}

    if myNumber=="NA":
        #print myNumber
        pass
    else:
        companyDict[myCompany][myYear]+=int(myNumber)


# pprint.pprint(companyDict)

finalCompanies = {}

for company in companyDict:
    numPoints = 0
    for year in companyDict[company]:
        if companyDict[company][year]!=0:
            numPoints+=1

    if numPoints > MIN_POINTS:
        finalCompanies[company] = companyDict[company]

print "Number of companies: %d" % (len(finalCompanies.keys()))

pprint.pprint(finalCompanies)

