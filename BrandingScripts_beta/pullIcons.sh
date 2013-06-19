#! /usr/bin/sh

if [ $# -lt 1 ]
    then
    read -p "Enter brand name: " brandName
    if [ -z "$brandName" ]
        then
        brandName="freenews"
    fi
else
    brandName=$1
fi




regexName="^<name>(.*)</name>$"
regexFile="^<file>(.*)x.*</file>$"

mkdir ~/Desktop/real_artwork/${brandName}-test
for line in `curl -s "http://test.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=icon&br=.${brandName}"`
do
    [[ $line =~ $regexName ]]
    name="${BASH_REMATCH[1]}"
    #echo "${name}"
    for line in `curl -s "http://test.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=icon&br=.${brandName}&name=${name}"`
    do
        [[ $line =~ $regexFile ]]
        #echo ${BASH_REMATCH[1]}
        if [[ ${BASH_REMATCH[1]} == 030 ]]
            then
            #echo ${BASH_REMATCH[1]}
            mkdir ~/Desktop/real_artwork/${brandName}-test/30x30
            #curl -silent -o ~/Desktop/real_artwork/${brandName}-test/30x30/${name}.png "http://test.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=icon&br=.${brandName}&name=${name}&w=30&h=30"
        elif [[ ${BASH_REMATCH[1]} == 045 ]]
            then
            #echo ${BASH_REMATCH[1]}
            mkdir ~/Desktop/real_artwork/${brandName}-test/45x45
            #curl -silent -o ~/Desktop/real_artwork/${brandName}-test/45x45/${name}.png "http://test.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=icon&br=.${brandName}&name=${name}&w=30&h=30"
        elif [[ ${BASH_REMATCH[1]} == 060 ]]
            then
            #echo ${BASH_REMATCH[1]}
            mkdir ~/Desktop/real_artwork/${brandName}-test/60x60
            #curl -silent -o ~/Desktop/real_artwork/${brandName}-test/60x60/${name}.png "http://test.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=icon&br=.${brandName}&name=${name}&w=30&h=30"
        fi
    done
    curl -s -o ~/Desktop/real_artwork/${brandName}-test/30x30/${name}.png "http://test.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=icon&br=.${brandName}&name=${name}&w=30&h=30"
    curl -s -o ~/Desktop/real_artwork/${brandName}-test/45x45/${name}.png "http://test.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=icon&br=.${brandName}&name=${name}&w=45&h=45"
    curl -s -o ~/Desktop/real_artwork/${brandName}-test/60x60/${name}.png "http://test.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=icon&br=.${brandName}&name=${name}&w=60&h=60"
done

#"http://test.freerange360.com/freenews/brandadmin?user=brandadmin-jer&pw=VymumAAA1&type=icon&br=.${brandName}&name=5things&w=60&h=60"