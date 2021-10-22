#!/bin/bash
#set -x
name=$1

ps3="请查看信息选择序号进行操作："
select menu in  查看相关服务器磁盘空间 tomcat应用重启 springboot快速重启 逐台重启 速狮快速刷新数据源 退出;do
case $REPLY in
1)
    echo "开始执行:$menu"
    ansible $1 -m shell -a "df -h"
    ;;
2)
    echo "开始执行:$menu"
    /root/tools/exadata/start/restart $name
    ;;
3)
    echo "开始执行:$menu"
    ansible $1 -m shell -a "/opt/$1/springboot.sh restart"
    ;;
4)
    echo "开始执行:$menu"
    ansible $1 -m shell -f 1 -a "/opt/$1/springboot.sh restart;sleep 15"
    ;;
5)
    echo "开始执行:$menu"
    /opt/scripts/flush_datasource.sh
    ;;
6)
   echo "开始执行:$menu"
   exit 0
   ;;
*)
   echo "输入序号错误"
esac
done
