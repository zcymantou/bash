#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2858349172
#Date:              2021-06-02
#FileName：         mysql.sh
#Description：      mysql安装
#Copyright (C):    2021 All rights reserved
#********************************************************************
##通用变量定义
datafile=/data/mysql
version=$1
low_version=$2
appfile=/opt/soft

#color
red='echo -e \033[031m'
green='echo -e \033[032m'
yellow='echo -e \033[033m'
blue='echo -e \033[036m'
end='\033[0m'




common () {
    echo "创建数据文件"
    sudo mkdir -pv ${datafile}
    id mysql ||(echo "mysql用户不存在，开始创建用户";groupadd -g 306 mysql;useradd -u 306 -g 306 mysql)
    ${green}"数据文件授权"${end}
    chown -R mysql.mysql /data/   
}

install_mysql56 () {
    ${gree}"开始下载${version}-${low_version}"${end}
    cd ${appsoft}
    if [ -e mysql-${low_version}-linux-glibc2.12-x86_64.tar.gz ];then 
        ${green}"安装包已经存在"${end}
    else
        sudo wget http://mirrors.163.com/mysql/Downloads/${version}/mysql-${low_version}-linux-glibc2.12-x86_64.tar.gz
        if [ $? -eq 0 ];then
            ${green}"${version}下载完成,开始安装......"${end}
         else
            ${red}"下载失败，退出安装"${end}
            exit 1
        fi
    fi 
    tar -xvf mysql-${low_version}-linux-glibc2.12-x86_64.tar.gz  -C /usr/local >/dev/null
    cd /usr/local
    ln -sv mysql-${low_version}-linux-glibc2.12-x86_64 mysql
    chown -R mysql.mysql mysql
    ${green}"程序目录准备完成，开始进行数据库初始化...."${end}
    /usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=${datafile} --basedir=/usr/local/mysql 
   if [ $? -eq 0 ];then
        echo "初始化完成"
   else 
        echo "初始化失败，请查看报错信息"
        exit 1
   fi
   sudo cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
   chkconfig --add mysqld

   ${green}"开始设置环境变量"${end}

   cat >>/etc/profile.d/mysql.sh<<EOF
PATH=/usr/local/mysql/bin:$PATH
EOF
source /etc/profile.d/mysql.sh
}

install_mysql57 () {
sudo yum install -y libaio numactl-libs
${gree}"开始下载${version}-${low_version}"${end}
    cd ${appsoft}
    if [ -e mysql-${low_version}-linux-glibc2.12-x86_64.tar.gz ];then 
        ${green}"安装包已经存在"${end}
    else
        sudo wget http://mirrors.163.com/mysql/Downloads/${version}/mysql-${low_version}-linux-glibc2.12-x86_64.tar.gz
        if [ $? -eq 0 ];then
            ${green}"${version}下载完成,开始安装......"${end}
         else
            ${red}"下载失败，退出安装"${end}
            exit 1
        fi
    fi 
    tar -xvf mysql-${low_version}-linux-glibc2.12-x86_64.tar.gz  -C /usr/local >/dev/null
    cd /usr/local
    ln -sv mysql-${low_version}-linux-glibc2.12-x86_64 mysql
    chown -R mysql.mysql mysql
    ${green}"程序目录准备完成，开始进行数据库初始化...."${end}
    /usr/local/mysql/bin/mysqld --initialize --user=mysql  --datadir=${datafile} --basedir=/usr/local/mysql
    sudo cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
    chkconfig --add mysqld
    systemctl start mysqld
   ${green}"开始设置环境变量"${end}
   cat >>/etc/profile.d/mysql.sh<<EOF
PATH=/usr/local/mysql/bin:$PATH
EOF
   source /etc/profile.d/mysql.sh
   #echo ""
   
   old_pwd=`sed -nr 's/.*(root@localhost: )(.*)/\2/p' /data/mysql/mysql.log`
   
   ${red}"注意查看初始密码，手动初始化root用户密码....."
   mysqladmin -uroot -p"$old_pwd" password 12345678
}


common
case $1 in 
MySQL-5.6)
    install_mysql56;;
MySQL-5.7)
    install_mysql57;;
esac




















