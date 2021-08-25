#
#********************************************************************
#Author:            zcy261
#QQ:                2858349172
#Date:              2021-02-22
#FileName：         check_v3.sh
#Description：      查redis节点上所有的未设置过期时间的key,加入可以控制的并行线程效果
#Copyright (C):    2021 All rights reserved
#********************************************************************



start=`date +%s`
passwd=$1
port=$2
hosts=$3

keys=`redis-cli -c -a $passwd -p $port -h $hosts keys "*" 2>/dev/null|sed -r 's/(.*)(")(.*)(")/\2/p'`

[ -e ./pzcy ] || mkfifo ./pzcy
exec 3<>./pzcy
rm -rf ./pzcy

for ((i=1;i<=20;i++))
do
    echo >&3  #文件描述符3
done

for i in $keys
do
read -u3
{
#   echo sueecss-$i
  num=`redis-cli -c -a $passwd -p $port -h $hosts ttl $i 2>/dev/null |awk '{printf $1}'`
#  echo $num 
 if [ $num -eq -1 ];then
     echo $i >>check.log
  
  redis-cli -c -a $passwd -p $port -h $hosts unlink $i
  fi
  echo >&3
}&
done
wait

end=`date +%s`
echo "${end}-${start}"|bc
echo -e "time-consuming: $SECONDS    seconds"

exec 3<&-                       #关闭文件描述符的读
exec 3>&-                       #关闭文件描述符的写

