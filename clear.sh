#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2362244529
#Date:              2021-08-06
#FileName：         clear.sh
#Description：      打包并删除
#Copyright (C):    2021 All rights reserved
#********************************************************************
RED='echo -e \033[031m'
GREEN='echo -e \033[032m'
YELLOW='echo -e \033[033m'
BLUE='echo -e \033[036m'
END='\033[0m'

BASE_DIR=/opt/cashier/logs/

logdir=${BASE_DIR}
logtime=`date +%Y%m`
logfile=`find ${logdir}  -mindepth 1  -maxdepth 1  -type d`


for i in $logfile;do
        tm=`echo ${i##*/}`
        oldtime=`echo "$tm-${logtime}"|bc`
        if [ $oldtime -lt 0 ];then
                echo ${oldtime}
                echo $i
                tar -zcvf ${i}.tar.gz ${i} && rm -rf ${i}
        fi

done

