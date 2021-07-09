#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2858349172
#Date:              2021-02-18
#FileName：         mysqldump.sh
#URL:               http://
#Description：      mysql分库备份
#Copyright (C):    2021 All rights reserved
#********************************************************************
user=root
passwd=zcy282013
#--master-data=2必须开启二进制日志
#-F =--flush_logs
mysql -u${user} -p${passwd} -e "show databases" 2>/dev/null|grep -Ev "Database|information_schema|performance_schema" |while read db;do
echo $db
mysqldump -u${user} -p${passwd} -B $db -F -E -R --triggers --single-transaction  --master-data=2  \
--flush-privileges --default-character-set=utf8  |gzip > /data/backup_db/${db}.sql.gz
done
