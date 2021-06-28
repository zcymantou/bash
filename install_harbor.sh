#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2858349172
#Date:              2021-06-28
#FileName：         install_harbor.sh
#Description：      harbor安装
#Copyright (C):    2021 All rights reserved
#********************************************************************
echo "#################开始安装docker环境################"
bash /opt/scripts/docker_install.sh


echo "#################开始安装docker-compose环境################"
wget https://github.com/docker/compose/releases/download/1.28.6/docker-compose-Linux-x86_64
cp docker-compose-Linux-x86_64 /usr/local/bin/docker-compose 


docker-compose -v
if [ $? -eq 0 ]
    echo ""

fi

