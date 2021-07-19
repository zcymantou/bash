#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2858349172
#Date:              2021-07-15
#FileName：         copy_auto.sh
#URL:               http://
#Description：      批量实现ssh公钥配置，前提是所以服务器密码都是一样的.提前配置好ssh服务
#Copyright (C):    2021 All rights reserved
#********************************************************************
RED='echo -e \033[031m'
GREEN='echo -e \033[032m'
YELLOW='echo -e \033[033m'
BLUE='echo -e \033[036m'
END='\033[0m'

IPLIST="10.0.0.1
10.0.0.2
10.0.0.3
10.0.0.4
10.0.0.5"
#设置需要配置的远程服务器的登录用户密码
export SSHPASS=12345
for IP in $IPLIST;do
    sshpass -e ssh-copy-id $ip
done
    
