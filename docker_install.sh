#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2858349172
#Date:              2021-01-08
#FileName：         docker_install.sh
#URL:               http://
#Description：      一键安装docker
#Copyright (C):    2021 All rights reserved
#********************************************************************
. /etc/init.d/functions

sudo yum install -y  redhat-lsb || apt-get install -y lsb-core
#color
red='echo -e \033[031m'
green='echo -e \033[032m'
yellow='echo -e \033[033m'
blue='echo -e \033[036m'
end='\033[0m'
Separator=`${blue}================================${end}`

os_type=`lsb_release -is`
os_vs=`cat /etc/redhat-release|sed -nr 's#(.*) ([0-9])\..*#\2#p'`

#yum install -y  redhat-lsb || apt-get install -y 

docker_version="19.03.10-3.el7"


centos () {
    # step 1: 安装必要的一些系统工具
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    # Step 2: 添加软件源信息
    #sudo yum-config-manager --add-repo https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/docker-ce.repo
#    sudo yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    sudo wget -P  /etc/yum.repos.d/ https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/centos/docker-ce.repo
    sudo sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo
    sudo yum clean all
    sudo yum install -y docker-ce-${docker_version} docker-ce-cli-${docker_version} || ${red}"安装失败"${end} && exit 1 
 #   sudo yum install http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.119.1-1.c57a6f9.el7.noarch.rpm
    echo "${Separator}"
    echo 
    ${green}"开始添加镜像加速"${end}
    sudo mkdir -p /etc/docker
    cat > /etc/docker/daemon.json <<EOF
     {
        "registry-mirrors": ["https://si7y70hh.mirrir.aliyuncs.com"]
     }
EOF
}

ubuntu () {
    rm /var/lib/dpkg/lock-frontend
    rm /var/lib/dpkg/lock
    docker_version="5:19.03.5~3-0~ubuntu-bionic"
    echo "安装相关依赖"
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common >/dev/null
    [ $? -eq 0 ] && echo "依赖安转完成" ||echo "安装失败，请检查环境配置"
    echo "开始安装GPG证书"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    rm /var/lib/dpkg/lock-frontend
    rm /var/lib/dpkg/lock 
    sudo apt-get install -y docker-ce=${docker_version} docker-ce-cli=${docker_version}
     ${green}"开始添加镜像加速"${end}
    sudo mkdir -p /etc/docker
    cat > /etc/docker/daemon.json <<EOF
     {
        "registry-mirrors": ["https://si7y70hh.mirrir.aliyuncs.com"]
     }
EOF
   systemctl enable --now docker
}

case $os_type in
 CentOS)     
     centos
     ;;
 Ubuntu)
    ubuntu
    ;;
 *)
     $yellow"版本不匹配"$end
     ;;
esac   


