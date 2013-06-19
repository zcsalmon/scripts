# coding: utf-8

import os
import urllib
import sys 
reload(sys) 
sys.setdefaultencoding("utf-8")

path = os.path.expanduser("~/Documents/OPML_Generation/newsblogs.txt")
target = os.path.expanduser("~/Documents/OPML_Generation/news-opml.xml")
outlines = []
i = 0

url="http://mpp/feedfilter/feed?link=%3Clink%3E?free&amp;a=web:1p&amp;paid=1&amp;e=ru:header_img&amp;url="


with open(path, "r") as f:
    #data = f.read().split()
    for line in f:
        name, twitter = line.strip().split("\t")
        
        i+=1
        
        outline = """<outline title="%(playername)s" mpp:client="cat_leaf,nothumb" mpp:order="%(i)s">
        <outline mpp:flags="exact,no_fs" type="rss" title="%(playername)s" xmlUrl="%(url)s%(handle)s"/>
        </outline>""" % {"playername":name,"i":i,"handle":twitter"url":url}
        
        outlines.append(outline)

opml =  """
<outline title="News Blogs">

%s

</outline>
""" % "\n".join(outlines)

print opml


with open(target, "w") as f:
    f.write(opml)