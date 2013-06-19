#!/usr/bin/python
# Filename: for.py

import requests
import re
import urllib2
import webbrowser
import os

filename = "names.txt"

FILE = open(filename, "w")

url = "http://www.tweeting-athletes.com/index.cfm?CatID=78&People=1"

r = requests.get(url)

contents = r.text

div = re.finditer("<div\sclass=\"name\"",contents)

for r in div:
	pName = r.group(1)
		
	fout = open(filename, "wb")
	fout.write(name)
	fout.close()
		
	print name
		

class FootballPlayer:
	itemno = 0
	
	def initItem(self, name, twitId):
		self.name = name
		self.twitId = twitId
		print 'this is the name %s' % self.name
		Item.itemno += 1




