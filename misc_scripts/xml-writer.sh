#!/bin/bash

# you can use read or VAR="$1" to setup these variables

NAME=
NAME1=
NAME2=
HANDLE=


echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<opml version=\"1.0\" xmlns:mpp=\"http://live.freerange360.com/mpp/\">
<head>
<title>Freenews Subscribed Feeds</title>
<ownerName>null null</ownerName>
<ownerEmail>testes_p@fr.com</ownerEmail>
<dateCreated>2012-08-08</dateCreated>
</head>
<body>" >> echotest.xml

i=0
n=0
c=0

for line in $(cat ~/Documents/names.txt)

do 

echo "$line"

i=`expr $i + 1`;
n=`expr $i % 3`

echo $n
if [ $n = 1 ]
then $line = "$NAME1"
fi
if [ $n = 2 ]
then $line = "$NAME2"
fi
if [ $n = 0 ]
then $line = "$HANDLE"



fi


done


#   echo "$value";

#for playername in TP1 TP2 TP3  
#	
#	do
#		 
#				i+=1
#				{
#					
#				echo "<outline title=\"${playername}\" mpp:client=\"container,webview\" mpp:order=\"${i}\">"
#				echo "<outline mpp:client=\"src\" type=\"rss\" title=\"${playername} - Twitter feed\" xmlUrl=\"http://mobile.twitter.com/${handle}\"/>"
#				echo "</outline>"
#				
#				} >> echotest.xml
#		
#	done
	
#for handle in 
	

#{
#echo "</body>"
#echo "</opml>"

#} >> echotest.xml