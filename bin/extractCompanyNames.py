import json
import sys
import os
import csv
import pprint
import networkx as nx

ROW_MAX = 57

ROW_MIN = 2

FILE_NAME = "../data/Tags.csv"
FILE_OUT = "../data/companyNames.txt"

fileIn = open(FILE_NAME,"rU")
fileOut = open(FILE_OUT,"w")

reader = csv.reader(fileIn,)

index = 0

# For each company

for row in reader:

    # If in excel range (not header and not tail)

    if index < ROW_MAX and index >= ROW_MIN:
        companyName = row[0]
        fileOut.write(companyName+"\n")

    index+=1


fileIn.close()
fileOut.close()