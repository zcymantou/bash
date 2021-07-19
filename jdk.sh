#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2858349172
#Date:              2021-07-19
#FileName：         jdk.sh
#URL:               http://
#Description：      The test script
#Copyright (C):    2021 All rights reserved
#********************************************************************
RED='echo -e \033[031m'
GREEN='echo -e \033[032m'
YELLOW='echo -e \033[033m'
BLUE='echo -e \033[036m'
END='\033[0m'

SOFTDIR=/opt/soft
VERSION=jdk-8u171-linux-x64.tar.gz
JDKDIR=/usr/local/java

java -version

if [ $? -eq 0 ];then
    $YELLOW"java环境已经存在，退出，如需请卸载现有的环境"$END
    exit 1;
else
    $YELLOW"创建安装目录"$END
    mkdir -pv $JDKDIR
    tar -xvf $SOFTDR/$VERSION -C $JDKDIR >/dev/null
    $GREEN"开始配置jdk环境变量"$END
    ln -s  /usr/local/java/jdk1.8.0_171    /opt/jdk1.8_171
    sudo cat > /etc/profile.d/java.sh <<EOF
export JAVA_HOME=/opt/jdk1.8_171
export PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME PATH
EOF
    source /etc/profile.d/java.sh
    $GREEN"请手动执行：source /etc/profile.d/java.sh加载环境变量....."$END
    sleep 15s
    java -version
    if [ $? -eq 0 ];then
        $GREEND"java 安装完成"$END
    else
        $RED"java安装失败，请查看错误,或者执行上述操作"$END
        exit 1;

    fi

fi





