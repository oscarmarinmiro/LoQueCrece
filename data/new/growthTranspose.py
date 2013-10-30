import csv
import pprint

eqDict = {
    2: ('Users',2009),
    3: ('Users',2010),
    4: ('Users',2011),
    5: ('Users',2012),
    6: ('Users',2013),
    7: ('Impact',2009),
    8: ('Impact',2010),
    9: ('Impact',2011),
    10: ('Impact',2012),
    11: ('Impact', 2013),
    12: ('Revenue',2008),
    13: ('Revenue',2009),
    14: ('Revenue',2010),
    15: ('Revenue',2011),
    16: ('Revenue',2012),
}

FILE_IN = "GrowthPatterns.csv"
FILE_OUT = "GPR.csv"

MAX_ROW = 71


fileIn = open(FILE_IN,"rU")

myReader = csv.reader(fileIn)

myReader.next()

numRow = 0

companyDict = {}

for row in myReader:

    if numRow < 71:
        companyName = row[0]

        if companyName not in companyDict:
            companyDict[companyName] = {}

            for year in range(2008,2014):
                companyDict[companyName][year] = {}
                for myType in ['Users','Impact','Revenue']:
                    companyDict[companyName][year][myType] = 0

        for i in range(2,17):
            data = row[i]
            year = eqDict[i][1]
            gType = eqDict[i][0]

            if data.isdigit():
                data = 5 - int(data)
                companyDict[companyName][year][gType] = data
                print "%s %d %d %s" % (companyName,data,year,gType)

    numRow+=1

pprint.pprint(companyDict)

fileOut = open(FILE_OUT,"wb")

# write header

fileOut.write(",".join(["Company","Year","Users","Impact","Revenue"])+"\n")

for company in companyDict:
    for year in range(2008,2014):
        fileOut.write(",".join([company,str(year),str(companyDict[company][year]['Users']),str(companyDict[company][year]['Impact']),str(companyDict[company][year]['Revenue'])])+"\n")

fileOut.close()