import os
import urllib
import sys
import requests

usr_path = os.path.expanduser("~/")

opml_path = usr_path + "scripts/push_empty/blank_p-opml.xml"

header = {'content-type': 'text/xml'}

url = "http://live.freerange360.com/freenews/brandadmin?user=zcsalmon&pw=GxN36400&type=opml&account=%s_p" % brand



