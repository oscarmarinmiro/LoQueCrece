import csv
import pprint

FILE_IN = "Full_Years_Five.csv"
FILE_OUT = "Full_Growth.csv"

MAX_ROW = 17

YEARS = range(1, 18)

TYPES = ['Revenue', 'Users', 'Units']

fileIn = open(FILE_IN,"rU")

myReader = csv.reader(fileIn)

headers = myReader.next()

numRow = 0

companyDict = {}

foundedDict = {}

for row in myReader:

    # pprint.pprint(row)

    if numRow < MAX_ROW:
        companyName = row[0]
        founded = row[1]
        type = row[2]

        foundedDict[companyName] = founded

        if companyName not in companyDict:
            companyDict[companyName] = {}

        for i in range(3,len(row)):
            # print i
            data = row[i]

            if type not in companyDict[companyName]:
                companyDict[companyName][type] = {}

            if data.isdigit():
                companyDict[companyName][type][i-2] = data
            else:
                companyDict[companyName][type][i-2] = ""

    numRow+=1

pprint.pprint(companyDict)

fileOut = open(FILE_OUT,"wb")


fileOut.write(",".join(["Company","Type","Year","RealYear","Data"])+"\n")

for company in companyDict:
    for type in TYPES:
        for year in YEARS:
            if year in companyDict[company][type]:
                data = str(companyDict[company][type][year])
            else:
                data = ""

            realYear = year + int(foundedDict[company]) - 1
            dataList = [company,type,str(year),str(realYear),str(data)]

            fileOut.write(",".join(dataList)+"\n")

fileOut.close()