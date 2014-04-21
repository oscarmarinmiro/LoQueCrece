import csv
import pprint
import math

FILE_IN = "All_Figures_In_One-V4.csv"
FILE_OUT = "SpeedData.csv"

MAX_ROW = 71

YEARS = range(2008, 2014)

HEADER = ['UsersAbsolute', 'ImpactAbsolute', 'RevenueAbsolute']

SPEEDS = {
    'UsersAbsolute': 'UserSpeed',
    'ImpactAbsolute': 'ImpactSpeed',
    'RevenueAbsolute': 'RevenueSpeed'
}

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

#pprint.pprint(companyDict)

speedDict = {}

print "======================="

for company in companyDict:
    print company
    for header in HEADER:
        headerYears = {}
        for year in YEARS:
            if header in companyDict[company][year]:
                data = companyDict[company][year][header]
                if len(data)>0:
                    headerYears[year] = data
                    print str(data)

        sortedYears = sorted(headerYears.keys())

        if len(sortedYears)> 1:

            pprint.pprint(sortedYears)
            firstYear = sortedYears[0]
            secondYear = sortedYears[-1]

            if len(sortedYears) > 2:
                firstYear = sortedYears[1]
                secondYear = sortedYears[-1]

            print str(firstYear)
            print str(secondYear)

            #speed = (float(companyDict[company][secondYear][header])-float(companyDict[company][firstYear][header])) / (float(secondYear)-float(firstYear))

            speed = (float(companyDict[company][secondYear][header])) / (float(companyDict[company][firstYear][header]))

            speed = speed / (float(secondYear)-float(firstYear))

            if company not in speedDict:
                speedDict[company] = {}

            speedDict[company][SPEEDS[header]] = speed


            #print tangent

            #arctan = math.atan(tangent)*180/math.pi

            #print arctan

pprint.pprint(speedDict)


fileOut = open(FILE_OUT,"wb")


fileOut.write(",".join(["Company"] + SPEEDS.values())+"\n")

for company in speedDict:
    pprint.pprint(speedDict[company])
    dataList = []
    for header in SPEEDS.values():
        if header in speedDict[company]:
            dataList.append(str(speedDict[company][header]))
        else:
            dataList.append("")

    dataList = [company]+dataList
    fileOut.write(",".join(dataList)+"\n")

fileOut.close()