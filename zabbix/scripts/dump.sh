#!/bin/bash
#
#********************************************************************
#Author:            zcy261
#Date:              2021-05-11
#FileName：         dump.sh
#Description：      dump info
#Copyright (C):    2021 All rights reserved
#********************************************************************
source /etc/profile.d/java.sh
#应用名称处理
project=$1
pro_name=`echo ${project%%_*}`


dir=/opt/log
date=`date +%F-%H-%M-%S`

[ -d $dir ] || mkdir -pv $dir
dump () {
export pid=`top -c -n 1|grep $pro_name|grep -Eo "[0-9]{3,}"|awk 'NR==1{print $1}'`
export tid=`top -H -p $pid -n 1|grep -A 1 PID|awk 'NR==2{print $2}'`
export oX=`printf "%x \n" $tid`
jstack -l $pid 

}

new_dump () {	
#按照名称dump信息
pid=`top -c -n 1|grep ${pro_name}|awk '{print $1,$2}'|grep -Eo "[0-9]{1,5}"`
export pid=${pid}
while true;
do
    if [[ ${pid} =~ [0-9]{1,5} ]];then
        break
    fi	
    pid=`top -c -n 1|grep ${pro_name}|awk '{print $1,$2}'|grep -Eo "[0-9]{1,5}"`
    export pid=${pid}
done

jstack -l $pid
}
new_dump > $dir/${pro_name}_$date.dump
