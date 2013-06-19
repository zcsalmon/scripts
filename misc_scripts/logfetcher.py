import sys
import os
import shutil
import subprocess
import glob

#path = glob.glob("/Volumes/MPP/Webtrends Logs/LFD/dcs5ri1ecvz5bd7whenj7qra6_2c4v/dcs5ri1ecvz5bd7whenj7qra6_2c4v-dcs-" + year + "-" + month + "-" + d + "-" + "*")

#print path
usr_path = os.path.expanduser("~/")
i = 0
cust = raw_input("LES or NYDN: ")
year = raw_input("Year (YYYY): ")
month = raw_input("Months (MM MM): ")
dates = raw_input("Dates (DD DD): ")
date_start, date_end = dates.split(" ")
month_start, month_end = month.split(" ")

dcsids_les = {
    "les_bb": "dcshd939cvz5bdw1oxsmol0b6_6j7k",
    "les_and": "dcscac440wz5bdg1hfkphj0b6_3l1k",
    "les_ip": "dcsyd8khsvz5bdg9fjsrfn0b6_5j4i",
    "les_ipad": "dcsnocoqtuz5bdkkyon0zo0b6_4d1y",
    "indy_bb": "dcs5ri1ecvz5bd7whenj7qra6_2c4v",
    "indy_and": "dcs8enr4zvz5bdvuc0gl2ora6_6n6v",
    "indy_ip": "dcsa2andovz5bdbjilc28tra6_6v3c"
    }
    
dcsids_nydn = {
    "NYDN_blackberry": "dcsfb2ktlvz5bdz5ojk4031b6_8o4n",
    "NYDN_iphone": "dcscswtoguz5bdb7txr2551b6_5g4x",
    "NYDN_android": "dcsyq341cvz5bdfmfwqprz0b6_9p2r"
    }
#dcsyq341cvz5bdfmfwqprz0b6_9p2r
#dcsyq341cvz5bdfmfwqprz0b6_9p2r
if cust == "LES":
    dcsids = dcsids_les.copy()
    print dcsids
elif cust == "NYDN":
    dcsids = dcsids_nydn.copy()
    print dcsids
else:
    print "Invalid Item"


for dcsid in dcsids.items():
    print dcsid
    dc_path = usr_path + "Webtrends_Logs" + month_start + "-" + month_end + "/" + cust + "_logs_" + dcsid[0] + "/"
    if not os.path.exists(dc_path):
        os.makedirs(dc_path)
        print "path " + cust + "_logs_" + dcsid[0] + " written"
    else:
        print "path " + cust + "_logs_" + dcsid[0] + " exists"
    
    for month in range(int(month_start), (int(month_end)+1)):
        if month < 10:
            month = "0" + str(month)
        for day in range(int(date_start), (int(date_end)+1)):
            if day < 10:
                day = "0" + str(day)
            #dirpath = os.path.expanduser("~/home")
            path = glob.glob("/Volumes/MPP/Webtrends Logs/LFD/" + dcsid[1] + "/" + dcsid[1] + "-dcs-" + year + "-" + str(month) + "-" + str(day) + "*")
            for item in path:
                print item
                shutil.copy2(item, dc_path)



#path = glob.glob("/Volumes/MPP/Webtrends Logs/LFD/dcs5ri1ecvz5bd7whenj7qra6_2c4v/dcs5ri1ecvz5bd7whenj7qra6_2c4v-dcs-" + year + "-" + month + "-" + "*")
#print path


#for filename in glob.glob(os.path.join(source_dir, '*.*')):

#dirpath = os.path.expanduser("~/home")
#for item in path:
    #print item
    #shutil.copy2(item, dirpath)

#print date_range.split(",")

#######################################################
#   DCS_ID Variables:                                 #
#######################################################

#les_bb = dcs5ri1ecvz5bd7whenj7qra6_2c4v
#les_and = dcs8enr4zvz5bdvuc0gl2ora6_6n6v
#les_ip = dcsa2andovz5bdbjilc28tra6_6v3c
#indy_bb = dcshd939cvz5bdw1oxsmol0b6_6j7k
#indy_and = dcscac440wz5bdg1hfkphj0b6_3l1k
#indy_ip = dcsyd8khsvz5bdg9fjsrfn0b6_5j4i

#while i > date