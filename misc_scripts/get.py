#!/usr/bin/python
# Filename: for.py

import requests
import re
import urllib2
import webbrowser
import os

#filename = "writeable.txt"
#FILE = open(filename,"w")

#i=0
#while 1:
for i in range(1, 10000):
	
	url = "http://xkcd.com/" + str(i) + "/"

	r = requests.get(url)
	contents = r.text
# <img  src="xyz" />
# "<img\s+src=\"([^\"]+"\.(jpg|png))\""
	res = re.finditer("<img\ssrc=\"(.*\.(jpg|png))\"",contents)
	for r in res:
		picture_page = r.group(1)
		
		
		
		res2 = re.search("terrible_small_logo",picture_page)
		res3 = re.search("a899e84",picture_page)
		if res2:
			pass
		elif res3:
			pass
		else:
			print picture_page
			
			
			
			filename = os.path.basename(picture_page)# "my_image" + str(i) + picture_page[-4:]
			print filename
			
			if os.path.exists(filename):
				print "Skipped"
				continue
			

	
			opener1 = urllib2.build_opener()
			page1 = opener1.open(picture_page)
			my_picture = page1.read()
	
	

			#print filename  # test
			fout = open(filename, "wb")
			fout.write(my_picture)
			fout.close()
	

			
		
		

		
		#print contents

	#FILE.writelines(r.text)
	



	#print r.text
	