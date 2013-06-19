import urllib2
import os
import sys
import re
import traceback

log_items = os.path.expanduser("~/scripts/noguids.log")
url_array = []
read_url = ""
regex = r"<link>(.*)</link>"
rejects = {}
matches = {}

class URLObject(object):
    URL = ""
    exceptionString = ""
    rejected = False
    matched_urls = {}
    rejects = {}
    
    def __repr__(self):
        return self.__unicode__()
    
    
    def __unicode__(self):
        return "\n".join((self.URL, self.exceptionString, str(self.rejected)))


with open(log_items, "r") as f:
    for files in f:
        sane_urls = re.findall("(http:[^ ]+)", files)
        for lines in sane_urls:
            obj = URLObject()
            obj.URL = lines
            #print obj.URL
            url_array.append(obj)
#print url_array
#print "\n".join([ unicode(obj) for obj in url_array ])

r = 0
x = 0
i = 0
for item in url_array:
    i = 0
    print "URL Tried: " + str(item.URL)
    item.matched_urls = {}
    item.rejects = {}
    try:
        
        open_url = urllib2.urlopen(item.URL)
        read_url = open_url.readlines()
        r = 0
        
    except Exception as ex:
        #print ex
        sys.exc_clear()
        print "URL Failed: " + item.URL
    for line in read_url:
        #print str(line + str(x)).decode('utf8')
        stuff = re.finditer(regex, line)
        for line in stuff:
            
            try:
                l_match = line.group(1).encode('ascii')
                #print "line match: " + l_match
                i = i + 1
                if not item.matched_urls.has_key(l_match):
                    item.matched_urls[l_match] = i
                else:
                    item.matched_urls[l_match] = item.matched_urls[l_match] + 1
                    #print item.rejects
                    item.rejected = True
                    #print "reject: " + item.URL + " because of link " + l_match
                    r = r + 1
                    item.rejects[l_match] = r
                    
            except Exception as item_ex:
                item.exceptionString = str(item_ex)
                
                #print item.exceptionString
                sys.exc_clear()
for item in url_array:
    print "URL: " + item.URL + "\nRejected: " + str(item.rejected) + "\n"
    for key in item.rejects.keys():
        print "Rejected Item: " + key + "\n"