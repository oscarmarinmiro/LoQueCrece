import json
import sys
import os
import csv
import pprint
import networkx as nx

# Category dictionary: TOMIND: Change accordingly

catDict = {
    2: ['Capital','Money'],
    3: ['Capital','Assets'],
    4: ['Human Resources','Property'],
    5: ['Human Resources', 'Knowledge'],
    6: ['Human Resources', 'Service'],
    7: ['Human Resources', 'Data'],
    8: ['Human Resources', 'Relationship'],
    9: ['Available Resources', 'Idle'],
    10: ['Available Resources', 'Libre']
}

ROW_MAX = 57

ROW_MIN = 2

def getGrowthData(fileName):
    struct = {}

    fileIn = open(fileName,"rU")

    reader = csv.reader(fileIn)

    reader.next()

    for row in reader:
        company = row[0]
        struct[company] = {}
        struct[company][2008] = int(row[1].replace(",","").replace(".",""))
        struct[company][2009] = int(row[2].replace(",","").replace(".",""))
        struct[company][2010] = int(row[3].replace(",","").replace(".",""))
        struct[company][2011] = int(row[4].replace(",","").replace(".",""))
        struct[company][2012] = int(row[5].replace(",","").replace(".",""))

    return struct

usersGrowth = getGrowthData("../data/Growth_experiment_revenue.csv")

pprint.pprint(usersGrowth)

FILE_NAME_TAGS = "../data/Tags.csv"

fileIn = open(FILE_NAME_TAGS,"rU")

reader = csv.reader(fileIn)

index = 0

nodes = {}
links = {}

nodesGrowth = {}
linksGrowth = {}

FIRST_YEAR = 2008
LAST_YEAR = 2012

years = range(FIRST_YEAR, LAST_YEAR+1)

dateTail = "-01-01"

def formatYear(year):
    return str(year)+dateTail

# For each company

for row in reader:

    # If in excel range (not header and not tail)

    if index < ROW_MAX and index >= ROW_MIN:

        companyName = row[0]

        if companyName in usersGrowth:
            print companyName
            companyDescription = row[1]

            # Create company node if not present

            if companyName not in nodes:
                nodes[companyName] = {'type': 'company', 'label':companyName, 'parentType': 'company', 'childType': 'company'}
                nodesGrowth[companyName] = {}

            for year in years:
                nodesGrowth[companyName][year] = usersGrowth [companyName][year]

            utilLinks = []

            # Get every utility

            for j in range(2,11):
                if row[j] != "":
                    utilName = ":".join(catDict[j])

                    # Create node if not present

                    if utilName not in nodes:
                        nodes[utilName] = {'type': 'utility', 'label': catDict[j][1],'parentType': catDict[j][0], 'childType': catDict[j][1]}
                        nodesGrowth[utilName] = {}

                    for year in years:
                        if year not in nodesGrowth[utilName]:
                            nodesGrowth[utilName][year] = 0
                        nodesGrowth[utilName][year]+=usersGrowth[companyName][year]


                    # Build linkName between company and utility

                    if companyName < utilName:
                        linkName = companyName + "-->" + utilName
                    else:
                        linkName = utilName + "-->" + companyName

                    if linkName not in links:
                        links[linkName] = 0
                        linksGrowth[linkName] = {}

                    for year in years:
                        if year not in linksGrowth[linkName]:
                            linksGrowth[linkName][year] = 0
                        linksGrowth[linkName][year]+=usersGrowth[companyName][year]

                    # Increment link (company-utility) and insert utility for this node to build later between utilities network

                    links[linkName] += 1

                    utilLinks.append(utilName)

            # For every utility stored for this node: increment inter-utility links

            for i in range(0,len(utilLinks)-1):
                for j in range(i, len(utilLinks)):
                    linkName = utilLinks[i] + "-->" + utilLinks[j]

                    if linkName not in links:
                        links[linkName] = 0
                        linksGrowth[linkName] = {}

                    for year in years:
                        if year not in linksGrowth[linkName]:
                            linksGrowth[linkName][year] = 0
                        linksGrowth[linkName][year]+=usersGrowth[companyName][year]

                    links[linkName] += 1

    index+=1

G = nx.Graph(mode="dynamic")

newLinks = {}

for link in links:

    weight = links[link]


    nodeSourceName = link.split("-->")[0]

    sourceGrowth = []

    for year in years:
        sourceGrowth.append((nodesGrowth[nodeSourceName][year],formatYear(year-1),formatYear(year)))

    nodes[nodeSourceName]['growth'] = sourceGrowth

    nodeTargetName = link.split("-->")[1]

    targetGrowth = []

    for year in years:
        targetGrowth.append((nodesGrowth[nodeTargetName][year],formatYear(year-1),formatYear(year)))


    nodes[nodeTargetName]['growth'] = targetGrowth


    G.add_node(nodeSourceName, nodes[nodeSourceName])
    G.add_node(nodeTargetName, nodes[nodeTargetName])

    linkGrowth = []

    for year in years:
        linkGrowth.append((linksGrowth[link][year],formatYear(year-1),formatYear(year)))

    newLinks[link] = {'growth':linkGrowth}

    G.add_edge(nodeSourceName, nodeTargetName , newLinks[link])

nx.write_gexf(G, "companyUtilityNetworkGrowthRevenue.gexf")



fileIn.close()


pprint.pprint(nodesGrowth)
pprint.pprint(linksGrowth)