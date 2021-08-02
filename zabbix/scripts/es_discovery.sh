#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2362244529
#Date:              2021-08-02
#FileName：         es_discovery.sh
#URL:               http://
#Description：      The test script
#Copyright (C):    2021 All rights reserved
#********************************************************************
RED='echo -e \033[031m'
GREEN='echo -e \033[032m'
YELLOW='echo -e \033[033m'
BLUE='echo -e \033[036m'
END='\033[0m'

IP=`hostname -I|cut -d " " -f 1`
curl -s -o /opt/zabbix-agent/scripts/es.txt   http://${IP}:9200/_cat/nodes?v&h=ip
heap_percent=`grep "${IP}" /opt/zabbix-agent/scripts/es.txt|awk '{print $2}'`
echo $heap_percent

