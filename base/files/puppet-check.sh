#!/bin/bash
echo "check ntp status============"
ntpdate
echo "                        "
echo "check hostname status========"
hostname
echo "                        "
echo  "check disk status========="
df -h |grep -v run|grep -v boot|grep -v sys|grep -v export
echo "                        "
echo "check dns status=========="
host puppet.jdcloud.local
echo "                        "
ping -c 1 puppet.jdcloud.local
echo "                        "
echo "check resolv file========="
cat /etc/resolv.conf
echo "                        "
echo "check hsots file========="
grep puppet /etc/hosts 
