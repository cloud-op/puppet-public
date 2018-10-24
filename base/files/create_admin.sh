#!/bin/bash

a=`id -u admin 2>/dev/null`
b=`id -g admin 2>/dev/null`
c=`id 1001 2>/dev/null`

if [ "$a" == "" -a "$b" == "" ]
then
	if [ "$c" == "" ]
	then 
		`groupadd -g 1001 admin && useradd -m -g 1001 -u 1001 admin`
		echo "admin has been added, id is 1001"
	else 
		`groupadd admin && useradd -m -g admin admin` 
		echo "admin has been added, id is not 1001"
	fi
else 
	echo "The group or user of admin has existed"
fi
exit 0
