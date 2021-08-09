#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2362244529
#Date:              2021-08-09
#FileName：         haproxy_install.sh
#Description：      haproxy 安装
#Copyright (C):    2021 All rights reserved
#********************************************************************
RED='echo -e \033[031m'
GREEN='echo -e \033[032m'
YELLOW='echo -e \033[033m'
BLUE='echo -e \033[036m'
END='\033[0m'
APPDIR='/opt'

echo "#####################"
$yellow"步骤1：依赖安装"$end
yum install -y pcre* gcc* systemd-devel openssl-devel readline-devel 
echo 
echo

echo "#####################"
$yellow"步骤2：lua环境安装"$end
wget http://www.lua.org/ftp/lua-5.3.5.tar.gz
tar -xvf lua-5.3.5.tar.gz -C /opt/
cd /opt/lua-5.3.5/ && make linux test
if [ $? -ne 0 ];then
    $red"lua编译环境依赖缺少，请安装相关依赖"$end
    exit 1;
else    
    $yellow"lua环境安装完成"$end
fi

echo "#####################"
$yellow"步骤3：haproxy 安装"$end
tar -xvf  haproxy-2.4.2.tar.gz
cd harproxy-2.4.2 
make TARGET=linux-glibc  USE_PCRE=1 USE_OPENSSL=1 ARCH=x86_64 \
USE_CPU_AFFINITY=1 USE_SYSTEMD=1 PREFIX=/opt/haproxy \
LUA_INC=/opt/lua-5.3.5/src/ LUA=LIB=/opt/lua-5.3.5/src/

make install PREFIX=/opt/haproxy














