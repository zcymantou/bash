#!/bin/bash
#
#********************************************************************
#Author:            zcy261
#QQ:                2858349172
#Date:              2021-02-19
#Copyright (C):     2021 All rights reserved
#:		    	
#********************************************************************
. /etc/init.d/functions

used=`df -h|grep opt|awk -F"([[:space:]]|%)+" '{print $(NF-1)}'`
echo -e "/opt目录当前使用率: \t${used}%"
echo -e "设定的阈值:         \t90%"
if [ ${used} -gt 90 ];then
    #find /opt/ms-sanfu*/logs/  -mtime +1 -regextype "posix-egrep" -regex  ".*\.log" -exec rm -f {} \;
    find /opt/ms-sanfu*/logs/  -mtime +1  -type f -regextype "posix-egrep" -regex  ".*\.(log|out)" -exec rm -f {} \;
    find /opt/tomcat/*/logs/ -mtime +3 -type f -regextype "posix-egrep" -regex  ".*" -exec rm -f {} \;
    action "日志清除成功"
else
   action "未到阈值无需清理"
   exit 0
fi
