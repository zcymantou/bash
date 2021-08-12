#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2362244529
#Date:              2021-08-11
#FileName：         mysql_install.sh
#URL:               http://
#Description：      The test script
#Copyright (C):    2021 All rights reserved
#********************************************************************
RED='echo -e \033[031m'
GREEN='echo -e \033[032m'
YELLOW='echo -e \033[033m'
BLUE='echo -e \033[036m'
END='\033[0m'

VERSION=mysql-5.7.33-linux-glibc2.12-x86_64.tar.gz
X_VERSION=`echo "$VERSION"|sed -nr 's/(.*)(\.tar\.gz)$/\1/p'`
DATADIR=/data/mysql

echo "### mysql安装步骤1:"
$YELLOW"安装相关依赖,和创建mysql用户、组"$END
sudo yum install -y libaio numactl-libs gcc* && $GREEN"依赖安装完成"$END
sudo groupadd mysql && sudo useradd mysql -g mysql && $GREEN"用户创建完成"$END || exit 1
echo 

echo "### mysql安装步骤2:"
sudo mkdir -pv $DATADIR && sudo chown -R mysql.mysql $DATADIR && id mysql
if [ $? -ne 0 ];then
    $RED"用户或目录安装失败"$END
    exit 1
else
    $GREEN"数据目录及用户创建完成"$END
fi
echo

echo "### mysql安装步骤3:安装包解压"
sudo tar -xvf $VERSION -C /usr/local >/dev/null
sudo ln -sv  /usr/local/$X_VERSION  /usr/local/mysql ||$RED"解压失败"$END










