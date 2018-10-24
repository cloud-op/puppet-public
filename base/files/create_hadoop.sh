#!/bin/bash

a=`id -u hadoop 2>/dev/null`
b=`id -g hadoop 2>/dev/null`
c=`id 1000 2>/dev/null`

if [ "$a" == "" -a "$b" == "" ]
then
	if [ "$c" == "" ]
	then 
		`groupadd -g 1000 hadoop && useradd -m -g 1000 -u 1000 hadoop`
		echo "hadoop has been added, id is 1000"
	else 
		`groupadd hadoop && useradd -m -g hadoop hadoop` 
		echo "hadoop has been added, id is not 1000"
	fi
else 
	echo "The group or user of hadoop has existed"
fi
exit 0
