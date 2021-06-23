#!/bin/bash
#
#********************************************************************
#Author:            zcy261
#Date:              2021-04-01
#FileName：         sendmail.sh
#Description：      UC4跑批结束通知
#Copyright (C):    2021 All rights reserved
#********************************************************************
#declare -A to
filedate=`date +%Y%m%d`
#to[1]="2858349172@qq.com"
#set -x
#to[0]="zhuangcy@sanfu.com"
#to[1]="huangzh@sanfu.com"
to[2]="chenwu@sanfu.com"
#邮件
message="`date +%F_%H:%M:%S` $1跑批结束"
subject="跑批检查"
us=`echo ${to[*]}|tr -s ' ' '\n'`
echo "$us" |while read user;do
   sendEmail  -f sfidc@sanfudb.com -t "$user" -s 192.168.0.61 -u "$subject"  -xu sfidc@sanfudb.com -xp sfidc  -m "$message"  -o message-charset=UTF-8
   echo "$user"
done


#机器人
#contents="`date +%F_%H:%M:%S`_$1跑批结束"
#sudo /opt/scripts/wechat.py 所有人 跑批检查  $contents
#touch /opt/scripts/log/`date +%Y%m%d`.txt
filename=/opt/scripts/log/`date +%Y%m%d`.txt
touch $filename
num=`cat $filename|wc -l`
if [ $1 == DS_DATAX_EXPORT -o $1 == DS_EVERY_0100AM -o $1 == PANDA_DAYPROC_EVERY_0100AM_CW5 -o $1 == DS_ALL_ETL -o $1 == DS_BIGDATA_IMPORT -o $1 == DS_DATAX_IM_RQB ];then
#content="`date +%F_%H:%M:%S`_$1跑批结束"
content="`date +%F_%H:%M:%S`_$1跑批结束,已完成跑批数::`expr $num + 1`"
echo "$content" >>/opt/scripts/log/`date +%Y%m%d`.txt
user=`echo $*|awk '{print $NF}'|tr -d ' '`
#wx () {
   sudo  curl 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?kexxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' \
   -H 'Content-Type: application/json' \
   -d '
{
    "msgtype": "markdown",
    "markdown": {
        "content": "<font color=\"info\">'${content}' \n <@zcy261> </font> "
    }
}'

echo 
echo "===================================================="
else
#   content="`date +%F_%H:%M:%S`_$1跑批结束"
   content="`date +%F_%H:%M:%S`_$1跑批结束,已完成跑批数::`expr $num + 1`"
   echo "$content" >>/opt/scripts/log/`date +%Y%m%d`.txt
   user=`echo $*|awk '{print $NF}'|tr -d ' '`
   sudo  curl 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=xxxxxxxxxxxxxxxxxxxxxxxxxxxx' \
   -H 'Content-Type: application/json' \
   -d '
 {
     "msgtype":"text",
     "text": {
         "content":"'$content'",
         "mentioned_list":["@all"]
        }
 }'
echo 
echo "===================================================="
fi   

