#!/usr/bin/python
import os, urllib, sys, urllib2, json, pickle, re
import objj

i = 0
postano = urllib2.urlopen('http://www.postano.com/php/peposts.php?sid=63277')
posts = postano.read()
array = []
dicts = {}
body = posts.split(',')

json_data = json.loads(posts)

regex = 

data = json.dumps(json_data, sort_keys=True, indent=4, separators=(',',': '))

for line in data.split( ',{' ):
    d = objj.Data()
    d.caption = line
    #print d.caption
    d.picture = re.
    for line in d.caption.split(','):
    d."""%s""" = regex







"""
with open('jsonFile.json', 'a') as f:
    f.write(data)
    f.close()"""
    
"""
for line in body:
    values = line.split(":")
    for line in values:
        other = line.split(",")
        for line in other:
            #print line
            array.append(line)
"""
