# coding: utf-8

import os
import urllib
import sys
import urllib2

from obj import Brand

fbdox = urllib2.urlopen('https://docs.google.com/spreadsheet/pub?key=0AgOsAHBW3ad-dE9mZm9xTmdiUFRlSHlPMWJQT0NUUnc&single=true&gid=0&output=csv')
twidox = urllib2.urlopen('https://docs.google.com/spreadsheet/pub?key=0AgOsAHBW3ad-dE9mZm9xTmdiUFRlSHlPMWJQT0NUUnc&single=true&gid=1&output=csv')
upface = os.path.expanduser("~/Documents/twit-fb/facebook.txt")
uptwit = os.path.expanduser("~/Documents/twit-fb/twitter.txt")
target = os.path.expanduser("~/test/svn/%(name)s/client.config")
facebook = fbdox.read()
twitter = twidox.read()


path = os.path.expanduser("~/")


configOutline = """
#import global_theme
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
""" % {"tkey":tkey,"tsecret":tsecret,"fkey":fkey,"fsecret":fsecret}

with open(upface, "w") as f:
    f.write(facebook)

with open(uptwit, "w") as f:
    f.write(twitter)

with open(uptwit, "r") as f:
    #data = f.read().split()
    for line in f:
        name = line.strip.split(',')
        print name
        print tkey
        print tsecret
        
        dirs = path + "test/svn/%(name)s/_themes/ios" % {"name":name}
        print dirs
        if not os.path.exists(dirs):
            os.makedirs(dirs)
        
        with open(target, "w") as f:
            f.write(configOutline)
        

with open(upface, "r") as f:

    for line in f:
        blank, fkey, fsecret = line.strip().split(',')
        print blank + '\n'
        print fkey + '\n'
        print fsecret + '\n'
        with open(target, "w") as f:
            f.write(configOutline)
            configOutline = """
            #import global_theme
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
            """ % {"tkey":tkey,"tsecret":tsecret,"fkey":fkey,"fsecret":fsecret}