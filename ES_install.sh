#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2858349172
#Date:              2021-07-13
#FileName：         ES_install.sh
#URL:               http://
#Description：      The test script
#Copyright (C):    2021 All rights reserved
#********************************************************************
RED='echo -e \033[031m'
GREEN='echo -e \033[032m'
YELLOW='echo -e \033[033m'
BLUE='echo -e \033[036m'
END='\033[0m'

$RED"java环境检查"$END
java -version || $RED"未安装java环境，退出，请安装java"$END && exit 1
$GREEN"开始安装ES，如需安装其他版本，请修改下载链接，ctrl+c退出"$END
sleep 15s

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.12.1-linux-x86_64.tar.gz


