from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream
import pprint
import json
import time
import rfc822
import traceback
import sys
import re
from pymongo import Connection



KEY_FILE = "../../data/companyNamesTuned.txt"

# Go to http://dev.twitter.com and create an app.
# The consumer key and secret will be generated for you after
consumer_key="blah"
consumer_secret="blah"

# After the step above, you will be redirected to your app's page.
# Create an access token under the the "Your access token" section
access_token="blah"
access_token_secret="blah"



class myListener(StreamListener):
    """ A listener handles tweets are the received from the stream.
    This is a basic listener that just prints received tweets to stdout.

    """

    def on_data(self, data):

        tweet = json.loads(data)

        try:
            if tweet['lang'] == 'en':
                print tweet
                other_date = time.strftime("%Y%m%d%H%M%S",rfc822.parsedate(tweet["created_at"]))
                tweet["created_at_other"] = other_date
                print "Other date: %s" % other_date
                # tweet["subcoll"] = subcoll
                collection.insert(tweet)
        except:
                print "*ERROR INESPERADO, AQUI LA TRAZA*"
                traceback.print_exc()

        return True

    def on_error(self, status):
        print status

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

    # Connect to mongodb

    connection = Connection()

    db = connection['loquecrece']

    collection = db['associationsv2']


    auth = OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)

    stream = Stream(auth, myListener())
    # stream.filter(locations=[-18.1590, 27.6363, 4.3279, 43.7900])
    stream.filter(track=companyNames)
