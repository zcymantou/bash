#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2362244529
#Date:              2021-08-02
#FileName：         mq_monitor.sh
#URL:               http://
#Description：      The test script
#Copyright (C):    2021 All rights reserved
#********************************************************************
RED='echo -e \033[031m'
GREEN='echo -e \033[032m'
YELLOW='echo -e \033[033m'
BLUE='echo -e \033[036m'
END='\033[0m'

LOG_FILE=/opt/zabbix-agent/scripts
FLAG=$1
case $FLAG in
status)
    sh /opt/rocketmq/bin/mqadmin brokerStatus -b localhost:10911   -n localhost:9876 > $LOG_FILE/mq.log 2>&1
    value=`grep -w $2 $LOG_FILE/mq.log |awk -F":" '{print $2}'|tr -d ' '|sed -nr 's/([0-9]{1,})([a-Z]{0,})/\1/p'`
    echo $value
    ;;
DIff)
   diff=`sh /opt/rocketmq/bin/mqadmin consumerProgress  -n localhost:9876 2>/dev/null|grep -vE "OFFLINE|#Group"|awk '{print $1}'`
   echo $diff|tr -s ' ' '\n'|while read LINE;do 
                 echo $LINE;

              done
;;
*)
    exit 1
    ;;
esac

