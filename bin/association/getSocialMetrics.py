import pprint
import requests
import json
import traceback
import sys
import re
from pymongo import Connection

KEY_FILE = "../../data/companyNamesTuned.txt"

def getListMatches(text, companyVector):

    matches = {}
    text = text.decode("utf8").lower()

    for company in companyVector:
        print "====="
        print company
        print company.lower()
        print text.lower()
        if re.search(r'\b'+company.lower()+r'\b',text.lower()) is not None:
            print "MATCH"
            matches[company] = 1
        else:
            if re.match(r'\b@'+company.lower()+r'\b',text.lower()) is not None:
                matches[company] = 1
    return matches


def getConcepts(inputText):
    r = requests.request('POST',"http://eeupm.com:9999/", data=json.dumps({"lang":"en","data":{"1":"hola"}}))
    pprint.pprint(r)




if __name__ == '__main__':

    # Get company names in a vector

    fileIn = open(KEY_FILE,"rb")

    companyNames = []

    for line in fileIn:
        line = line.rstrip()
        companyNames.append(line)

    print "Company Names"
    print "============="

    pprint.pprint(companyNames)

    print "============="

    fileIn.close()

    # # Connect to mongodb
    #
    # connection = Connection()
    #
    # db = connection['loquecrece']
    #
    # collection = db['associationsv2']

    text = "@Odesk: Kiva and fon are the more wonderful services in the world"

    companyDict = getListMatches(text, companyNames)

    pprint.pprint(companyDict)

    conceptDict = getConcepts(text)