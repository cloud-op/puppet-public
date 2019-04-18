#!/bin/bash
echo "check ntp status============"
date
ntpdate
echo "                        "
echo "                        "
echo "check hostname status========"
hostname
echo "                        "
echo  "check disk status========="
df -h |grep -v run|grep -v boot|grep -v sys|grep -v export|grep -v tmpfs
echo "                        "
echo "check dns status=========="
host puppet.jdcloud.local
echo "                        "
echo "                        "
ping -c 1 puppet.jdcloud.local
echo "                        "
echo "                        "
echo "check resolv file========="
cat /etc/resolv.conf
echo "                        "
echo "                        "
echo "check hsots file========="
grep puppet /etc/hosts 
echo "其他常见错误"
echo "检查pp文件的后缀是否为.pp"
echo "检查.pp文件的名称和site.pp里面是否完全相同"
