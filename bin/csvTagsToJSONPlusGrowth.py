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

FILE_NAME = "../data/Tags.csv"

fileIn = open(FILE_NAME,"rU")

reader = csv.reader(fileIn,)

index = 0

nodes = {}
links = {}

# For each company

for row in reader:

    # If in excel range (not header and not tail)

    if index < ROW_MAX and index >= ROW_MIN:
        companyName = row[0]
        companyDescription = row[1]

        # Create company node if not present

        if companyName not in nodes:
            nodes[companyName] = {'type': 'company', 'label':companyName, 'parentType': 'company', 'childType': 'company'}

        utilLinks = []

        # Get every utility

        for j in range(2,11):
            if row[j] != "":
                utilName = ":".join(catDict[j])

                # Create node if not present

                if utilName not in nodes:
                    nodes[utilName] = {'type': 'utility', 'label': catDict[j][1],'parentType': catDict[j][0], 'childType': catDict[j][1]}

                # Build linkName between company and utility

                if companyName < utilName:
                    linkName = companyName + "-->" + utilName
                else:
                    linkName = utilName + "-->" + companyName

                if linkName not in links:
                    links[linkName] = 0

                # Increment link (company-utility) and insert utility for this node to build later between utilities network

                links[linkName] += 1

                utilLinks.append(utilName)

        # For every utility stored for this node: increment inter-utility links

        for i in range(0,len(utilLinks)-1):
            for j in range(i, len(utilLinks)):
                linkName = utilLinks[i] + "-->" + utilLinks[j]

                if linkName not in links:
                    links[linkName] = 0

                links[linkName] += 1

    index+=1

G = nx.Graph()

for link in links:

    weight = links[link]


    nodeSourceName = link.split("-->")[0]
    nodeTargetName = link.split("-->")[1]

    G.add_node(nodeSourceName, nodes[nodeSourceName])
    G.add_node(nodeTargetName, nodes[nodeTargetName])
    G.add_edge(nodeSourceName, nodeTargetName , weight = weight)


nx.write_gexf(G, "companyUtilityNetwork.gexf")



fileIn.close()