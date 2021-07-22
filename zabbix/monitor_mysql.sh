#!/bin/bash
#
#********************************************************************
#Author:            zcy261
#QQ:                2858349172
#Date:              2021-03-01
#FileName：         monitor_mysql.sh
#Description：      mysql主从监控和单机脚本
#Copyright (C):    2021 All rights reserved
#********************************************************************
user=$1
passwd=$2
monitor=$3

#单机监控
command () {
    #mysql -u${user} -p${passwd} -e "show global status where Variable_name='${monitor}'" 2>/dev/null|awk -v var1=${monitor} '{var1;print $2}'
    mysql -u${user} -p${passwd} -e "show global status where Variable_name='${monitor}'" 2>/dev/null|awk  'NR==2{print $2}'
}


case $monitor in
Com_select)
    #累计查询sql
    command ;;
Com_delete)
    #累计删除sql
    command ;;
Com_update)
    #累计更新sql
    command ;;
Com_insert)
    #累计插入sql
    command ;;
version)
    #sql版本
    mysql -u${user} -p${passwd} -e "select version();" 2>/dev/null|awk 'NR==2';;
uptime)
    #sql运行时长
    mysql -u${user} -p${passwd} -e "show global status like 'uptime'" 2>/dev/null|awk 'NR==2{print $2}' ;;
max_connection)
    #数据库最大连接数
    mysql -u${user} -p${passwd} -e "show variables like '%max_connections%'" 2>/dev/null |awk 'NR==2{print $2}';;
Threads_cached)
    #当前线程缓存存在的线程
    mysql -u${user} -p${passwd} -e "show status like 'Threads_cached%'" 2>/dev/null |awk 'NR==2{print $2}';;
Threads_connected)    
    #已经连接的mysql线程数，小于max_connections
    mysql -u${user} -p${passwd} -e "show status like 'Threads_connected%'" 2>/dev/null |awk 'NR==2{print $2}';;
Threads_running)
    #正在运行的线程连接数
    mysql -u${user} -p${passwd} -e "show status like 'Threads_running%'" 2>/dev/null |awk 'NR==2{print $2}';;
Slave_IO_Running)
   mysql -u${user} -p${passwd} -e "show slave status\G" 2>/dev/null |awk '/Slave_IO_Running/{print $2}' ;;
Slave_SQL_Running)
   mysql -u${user} -p${passwd} -e "show slave status\G" 2>/dev/null |awk '/Slave_SQL_Running/{print $2}' ;;
user_type)
   #主从判断
   num=`mysql -u${user} -p{passwd} -e "show slave status" 2>/dev/null|wc -l`
   if [ $num -gt 3 ];then
      user_type=slave
   else
      user_type=master
   fi ;;
   #echo $user_type ;;
Seconds_Behind_Master)
    #从库复制延迟时间
    mysql -u${user} -p${passwd} -e "show slave status\G" 2>/dev/null |awk '/Seconds_Behind_Master/{print $2}' ;;


esac

