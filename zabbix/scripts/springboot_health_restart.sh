#!/bin/bash
#
#********************************************************************
#Author:		    zcy261
#Date: 			    2021-04-14
#FileName：		    springboot_health_restart.sh
#********************************************************************
#
#color
set -x
red='echo -e \033[031m'
green='echo -e \033[032m'
yellow='echo -e \033[033m'
blue='echo -e \033[036m'
end='\033[0m'

utime=`cat /proc/uptime|awk -F'.' '{print $1}'`


project=$1
pro_name=`echo ${project%%_*}`

dir=/opt/log
date=`date +%F-%H-%M-%S`
scripts_dir=/opt/zabbix-agent/scripts
[ -d /opt/log ] || mkdir /opt/log
restart () {
echo -e "=============================================="
$red"开始重启${pro_name}服务: `date +%F_%H:%M:%S`"$end
#ps -ef|grep -w ${pro_name}|grep -vE "grep|console|bash"|awk '{print $2}'|xargs kill -9
/opt/${pro_name}/springboot.sh restart
$green"服务${pro_name}重启完毕: `date +%F_%H:%M:%S`"$end
sleep 5
echo "重启失败，重新启动"
num=`ps -ef|grep ${pro_name}|grep -Ev "cronolog|grep|bash"|wc -l`
if [ $num -eq 0 ];then
	/opt/${pro_name}/springboot.sh start
fi
echo -e "==============================================\n"

}

new_dump () {	
#按照名称dump信息
pid=`jps -l|grep ${pro_name}|awk '{print $1}'`
export pid=${pid}
jstack -l $pid
echo
echo
echo
$red"####以下为最高cpu的线程dump信息####"$end
#top -n 1 -H -p $pid|grep -A 2 "PID"|awk '{print $1,$2,$3}'
tip=`top -b -n 1 -H -p ${pid}|sed -nr '8,8p'|sed  -nr 's/([0-9]{1,5}) (.*)/\1/p'`
echo $tip
ox=`printf "%x" $tip`
echo "$ox"
jstack -l $pid |grep -A 40 ${ox}
$green'请使用printf "%x" number进行进制转换查询'$end
}
new_dump > $dir/${pro_name}_$date.dump
restart $pro_name $2 >>/opt/zabbix-agent/scripts/ms-restart.log
