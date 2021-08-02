#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2362244529
#Date:              2021-08-02
#FileName：         mq_discovery.sh
#URL:               http://
#Description：      The test script
#Copyright (C):    2021 All rights reserved
#********************************************************************
RED='echo -e \033[031m'
GREEN='echo -e \033[032m'
YELLOW='echo -e \033[033m'
BLUE='echo -e \033[036m'
END='\033[0m'

diff=`sh /opt/rocketmq/bin/mqadmin consumerProgress  -n localhost:9876 2>/dev/null|grep -vE "OFFLINE|#Group"|awk '{print $1}'`
NUM=`echo $diff|wc -l`
echo '{"data":['
echo $diff|tr -s ' ' '\n'|while read LINE;do
#        echo '{"data":['
    echo -n '{"{#DIFF}":"'
    echo -n "$LINE"
    echo '"},'
done
echo '{"{#DIFF}":"None"}'
echo ']}'
