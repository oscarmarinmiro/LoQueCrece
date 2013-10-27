from pattern.web import *


engine = Bing(license=None,throttle=5.0,language="en")
for i in range(1,100):
    for result in engine.search('airbnb', type=SEARCH, start=i):
        print plaintext(result.text)+"\n"
        print plaintext(result.url)+"\n"