import json
import sys
import os
import csv
import pprint
import networkx as nx

# Category dictionary: TOMIND: Change accordingly

catDict = {
    3: ['CrowdSourced','CrowdSourced'],
    4: ['CrowdSourced','Centralized'],
    5: ['Input','Money'],
    6: ['Input','Property'],
    7: ['Input','Knowledge/Education'],
    8: ['Input','Service'],
    9: ['Input','Media/Entertainment'],
    10: ['Input','Data'],
    11: ['Input','Relationships'],
    12: ['Structure','Service'],
    13: ['Structure','Market'],
    14: ['Structure','Platform'],
    15: ['Outcome','Commons/Access'],
    16: ['Outcome','Occupation/Redistribution'],
    17: ['Outcome','Breaktrough/Upgrade'],
    18: ['Outcome','Producer']
}


def numConvert(myString):
    if myString.isdigit():
        return int(myString)
    else:
        return 0

def getGrowthData(fileName):
    struct = {}

    fileIn = open(fileName,"rU")

    reader = csv.reader(fileIn)

    reader.next()

    for row in reader:
        company = row[0]
        struct[company] = {}
        struct[company][2008] = numConvert(row[1].replace(",","").replace(".",""))
        struct[company][2009] = numConvert(row[2].replace(",","").replace(".",""))
        struct[company][2010] = numConvert(row[3].replace(",","").replace(".",""))
        struct[company][2011] = numConvert(row[4].replace(",","").replace(".",""))
        struct[company][2012] = numConvert(row[5].replace(",","").replace(".",""))

    return struct

ROW_MAX = 69

ROW_MIN = 2

FILE_NAME = "../data/NewTags.csv"

fileIn = open(FILE_NAME,"rU")

reader = csv.reader(fileIn)

index = 0

crowdDict = {}

# For each company

for row in reader:



    # If in excel range (not header and not tail)

    if index < ROW_MAX and index >= ROW_MIN:


        companyName = row[0]
        companyDescription = row[1]
        if row[3] == "1":
            crowdDict[companyName] = True
        else:
            crowdDict[companyName] = False

    index+=1

# Read growth data

growthData = getGrowthData("../data/CompaniesUnitsGrowth.csv")

pprint.pprint(growthData)
pprint.pprint(crowdDict)

fileOut = open("../data/UnitsPlusTag.csv","wb")

for company in crowdDict:
    companyName = company
    myData = []
    myData.append(companyName)
    for year in range(2008,2013):
        myData.append(str(growthData[companyName][year]))
    myData.append(str(crowdDict[companyName]))
    pprint.pprint(myData)

    fileOut.write(",".join(myData)+"\n")

    # fileOut.write(",".join([com]))

fileOut.close()