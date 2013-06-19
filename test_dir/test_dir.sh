#!/bin/bash
#set -x
func1()
{
for number in $@
do
echo $number 
done
}
args=''
read -p "What da rgs??:" args

func1 $args
