import csv
import pprint

FILE_IN = "All_Figures_In_One-V3.csv"
FILE_OUT = "Growth-V3.csv"

MAX_ROW = 71

YEARS = range(2008, 2014)

HEADER = ['UsersAbsolute', 'ImpactAbsolute', 'RevenueAbsolute']

fileIn = open(FILE_IN,"rU")

myReader = csv.reader(fileIn)

category = myReader.next()
years = myReader.next()

numRow = 0

companyDict = {}

for row in myReader:

    # pprint.pprint(row)

    if numRow < MAX_ROW:
        companyName = row[0]
        description = row[1]
        year = row[2]

        if companyName not in companyDict:
            companyDict[companyName] = {}

        for i in range(3,len(row)):
            # print i
            data = row[i]
            year = int(years[i])
            gType = category[i]

            if year not in companyDict[companyName]:
                companyDict[companyName][year] = {}

            # print data
            print year
            print gType
            print companyName

            data = data.replace(",","").replace(".","")

            if data.isdigit():
                companyDict[companyName][year][gType] = data
            else:
                companyDict[companyName][year][gType] = ""

    numRow+=1

# pprint.pprint(companyDict)

fileOut = open(FILE_OUT,"wb")


fileOut.write(",".join(["Company","Year"] + HEADER)+"\n")

for company in companyDict:
     for year in YEARS:
         dataList = []
         for header in HEADER:
             if header in companyDict[company][year]:
                 dataList.append(str(companyDict[company][year][header]))
             else:
                 dataList.append("")
         dataList = [company,str(year)]+dataList
         fileOut.write(",".join(dataList)+"\n")

fileOut.close()