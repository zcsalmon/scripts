#!/bin/sh
cd ~/../../Volumes/MPP/Webtrends\ Logs/
/usr/local/bin/lftp sftp://sftp.webtrends.com/ -e 'mirror --verbose --only-missing LFD LFD' -u freerange\\jwarren,'VymumAAA111!!!'