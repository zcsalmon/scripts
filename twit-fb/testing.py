# coding: utf-8

import os
import urllib
import sys
import urllib2
import json
import pysvn


client = pysvn.Client()
#themes = json.loads(myJSON)

#print themes["themes"][1] # 5things

#themes["themes"].append("global")

#myJSON = json.dumps(themes, indent=True)
#print myJSON

class Brand(object):
    name = ""
    fb_key = ""
    fb_sec = ""
    tw_key = ""
    tw_sec = ""
    
    def __str__(self):
        return ",".join((self.name, self.fb_key, self.fb_sec, self.tw_key, self.tw_sec))


path = os.path.expanduser("~/")

fbdox = urllib2.urlopen('https://docs.google.com/spreadsheet/pub?key=0AgOsAHBW3ad-dE9mZm9xTmdiUFRlSHlPMWJQT0NUUnc&single=true&gid=0&output=csv')
twidox = urllib2.urlopen('https://docs.google.com/spreadsheet/pub?key=0AgOsAHBW3ad-dE9mZm9xTmdiUFRlSHlPMWJQT0NUUnc&single=true&gid=1&output=csv')
upface = os.path.expanduser("~/Documents/twit-fb/facebook.txt")
uptwit = os.path.expanduser("~/Documents/twit-fb/twitter.txt")

facebook = fbdox.read()
twitter = twidox.read()



with open(upface, "w") as f:
    f.write(facebook)

with open(uptwit, "w") as f:
    f.write(twitter)
#dirs = path + "test/svn/%(name)s/_themes/ios" % {"name":name}
#print dirs
#if not os.path.exists(dirs):
    #os.makedirs(dirs)

brands = []

with open(uptwit, "r") as f:
    #data = f.read().split()
    for line in f:
        b = Brand()
        
        b.name, b.tw_key, b.tw_sec = [ i.strip() for i in line.split(',') ]
        
        brands.append(b)
        
        #print b.name
        #print b.tw_key
        #print b.tw_sec
        
with open(upface, "r") as f:

    for line in f:
        
        fb = Brand()
        
        fb.name, fb.fb_key, fb.fb_sec = line.strip().split(',')
        
        found = None
        for b in brands:
            if fb.name == b.name:
                found = b
                break
        
        if found is None:
            found = fb
            brands.append(fb)
        
        found.fb_key = fb.fb_key
        found.fb_sec = fb.fb_sec
        print found.name
        print found.fb_sec
        print found.fb_key
        print found.tw_sec
        print found.tw_key
        

i = 0
for found in brands:
    i += 1
    print "i: %d" % i
    dirs = path + "/svn/media/%s/_themes/global/ios" % found.name
    print dirs
    if not os.path.exists(dirs):
        os.makedirs(dirs)

    target = path + "svn/media/%s/_themes/global/client.config" % found.name
    print "target = " + target
    ios = path + "svn/media/%s/_themes/global/ios/client.config" % found.name
    print "ios = " + ios
    jsonPath = path + "svn/media/%s/_themes/themes.json" % found.name
    print "path = " + jsonPath
    clientConfig = """#import global_theme
share_services=twitter,facebook
share_twitter_method=oauth
share_facebook_method=oauth
share_linkedin_method=web
share_googleplus_method=web

share_twitter_xauth_key=%(tkey)s
share_twitter_xauth_secret=%(tsecret)s
share_twitter_oauth_key=%(tkey)s
share_twitter_oauth_secret=%(tsecret)s

share_facebook_xauth_key=%(fkey)s
share_facebook_xauth_secret=%(fsecret)s
share_facebook_oauth_key=%(fkey)s
share_facebook_oauth_secret=%(fsecret)s
""" % {"tkey":found.tw_key,"tsecret":found.tw_sec,"fkey":found.fb_key,"fsecret":found.fb_sec}
    print target
    myJSON = ''
    iosCC = """share_facebook_method=xauth
share_twitter_method=oauth
"""
    print iosCC
    #print clientConfig
    if not os.path.exists(target):
        with open(target, "w") as f:
            f.write(clientConfig)
            
    if not os.path.exists(ios):
        with open(ios, "w") as f:
            f.write(iosCC)
    
    themes = {"themes":["global"]}
    
    if os.path.exists(jsonPath):
        with open(jsonPath, "r") as f:
            themes = json.load(f)
    
    print `themes`
    
    if not 'global' in themes["themes"]:
        themes["themes"].append("global")
    
    myJSON = json.dumps(themes)
    with open(jsonPath, "w") as f:
        f.write(myJSON)
    

shell = path + "/Documents/twit-fb/shellTest.sh"
sht = []
for found in brands:
    
    print found.name
    sht.append(found.name)

shellTemp = """#!/bin/bash
for brand in %s
do
svn up /Users/zcsalmon/svn/media/$brand
svn add /Users/zcsalmon/svn/media/$brand/_themes/*
svn ci /Users/zcsalmon/svn/media/$brand/_themes/* -m "adding facebook and twitter support to $brand"
done
""" % " ".join(sht)

with open(shell, "w") as f:
    f.write(shellTemp)






