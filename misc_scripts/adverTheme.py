# coding: utf-8

import os
import urllib
import sys
import urllib2
import json
import re

### reloads system to actually set to utf-8
reload(sys) 
sys.setdefaultencoding("utf-8")


### brand object storing partner and site ids for each brand object
class Brand(object):
    brand = ""
    bb_site_id = ""
    bb_part_id = ""
    and_site_id = ""
    and_part_id = ""
    ipad_site_id = ""
    ipad_part_id = ""
    ip_site_id = ""
    ip_part_id = ""
    
    def __repr__(self):
        return self.__unicode__()
    
    def __unicode__(self):
        return ",".join((self.brand, self.bb_site_id, self.bb_part_id, self.and_site_id, self.and_part_id, self.ipad_site_id, self.ipad_part_id, self.ip_site_id, self.ip_part_id))


### setting shit up to get the list of brands from the server
bList = urllib2.urlopen('http://live.freerange360.com/freenews/brandadmin?user=brandadmin&pw=brandy-247&type=brand')
printlist = bList.read()

brands = []
regex = r"<brand\sid=\"\.(.+?)\""

stuff = re.finditer(regex, printlist)

for match in stuff:
    
    b = Brand()
    b.brand = match.group(1)
    brands.append(b)
    
for b in brands:
    
    url = "http://live.freerange360.com/freenews/brandadmin?user=brandadmin&pw=brandy-247&type=client&br=.%s" % b.brand
    
    adminURL = urllib2.urlopen(url)
    
    propList = adminURL.read()
    
    regex_and = r"and.adplacement\">([a-zA-Z0-9,]+)</entry>"
    regex_bb = r"bb.adplacement\">([a-zA-Z0-9,]+)</entry>"
    regex_ip = r"ip.adplacement\">([a-zA-Z0-9,]+)</entry>"
    regex_ipad = r"ipad.adplacement\">([a-zA-Z0-9,]+)</entry>"
    
    and_adstuff = re.finditer(regex_and, propList)
    
    for line in and_adstuff:
        b.and_site_id, b.and_part_id = line.group(1).split(',')
        print b.brand, b.and_site_id, b.and_part_id
        
    bb_adstuff = re.finditer(regex_bb, propList)

    for line in bb_adstuff:
        b.bb_site_id, b.bb_part_id = line.group(1).split(',')
        #print b.bb_site_id, b.bb_part_id

    ip_adstuff = re.finditer(regex_ip, propList)

    for line in ip_adstuff:
        b.ip_site_id, b.ip_part_id = line.group(1).split(',')
        #print b.ip_site_id, b.ip_part_id

    ipad_adstuff = re.finditer(regex_ipad, propList)

    for line in ipad_adstuff:
        b.ipad_site_id, b.ipad_part_id = line.group(1).split(',')
        #print b.ipad_site_id, b.ipad_part_id


usr_path = os.path.expanduser("~/")

for b in brands:
    print b.brand + " Blackberry " + b.bb_site_id + " " + b.bb_part_id

"""
bb_site_id =
bb_part_id =
and_site_id 
and_part_id 
ipad_site_id
ipad_part_id
ip_site_id =
ip_part_id =


print "\n".join([ unicode(b) for b in brands ])
"""
