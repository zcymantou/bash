#!/bin/bash
#
#********************************************************************
#Author:		    zhuangchangye
#QQ: 			    2858349172
#Date: 			    2020-12-17
#FileName：		    install_zbx_agent.sh
#********************************************************************
#set -x 
. /etc/init.d/functions

#file
in_dir=/opt/zabbix-agent
soft_dir=/opt/soft/zabbix

#color
red='echo -e \033[031m'
green='echo -e \033[032m'
yellow='echo -e \033[033m'
blue='echo -e \033[036m'
end='\033[0m'
Separator=`${blue}================================${end}`

#version
pcre_vs=`rpm -qa pcre|sed -nr  's/.*-([0-9])\..*/\1/p'`
os_vs=`cat /etc/redhat-release|sed -nr 's#(.*) ([0-9])\..*#\2#p'`

#判断sudo权限
flag=`sudo -n true`

test () {
    if [ ${pcre_vs} -lt 8 -a ${os_vs} -lt 7 ];then
        sudo -n true
        if [ $? -eq 0 ];then
              install_pcre
              install_agent
           else
             ${red}"用户权限不足"$end
             exit 1
        fi       
      else
        install_pcre
        install_agent
    fi
}


out () {

  zbx_pid=`ps -ef|grep zabbix_agent|grep -v grep |wc -l`
    if [ ${zbx_pid} -gt 0 ];then
        $yellow"zabbix_agent is runing"$end
        exit 0
    fi

}

install_pcre () {
    
    if [ ${pcre_vs} -lt 8 ];then
       tar -xvf ${soft_dir}/pcre-8.32.tar.gz -C ${soft_dir} >/dev/null && cd ${soft_dir}/pcre-8.32
       sudo ./configure --prefix=/usr/local/pcre >/dev/null && sudo make install >/dev/null 
       if [ $? -le 0 ];then
            $red"pcre编译失败"$end
 #           exit 1
       fi 
      sudo ln -s   /usr/local/pcre/lib/libpcre.so.1.2.0    /lib64/libpcre.so.1 && sudo ldconfig || $yellow"注意文件是否已经存在"$end  && sudo ldconfig
       $green"pcre安装成功"$end
       echo $Separator
     else 
        $green"无需安装新的pcre"$end      
    fi
}


install_agent () {

#    zbx_pid=`ps -ef|grep zabbix_agent|grep -v grep |wc -l`
#    if [ ${zbx_pid} -gt 0 ];then
#        $yellow"zabbix_agent is runing"$end
#        exit 0
#    fi


 #   ps -ef|grep zabbix|awk '{print $2}'|xargs kill -9
    echo ${Separator}
    $green"开始安装相关依赖"$end
    echo ${Separator}
    echo 
    cd ~ && sudo yum install -y pcre* >/dev/null
    if [ $? -eq 0 ];then
        echo ${Separator}
        $green"依赖安装成功"$end
        echo ${Separator}
        echo 
    fi
    
    [ -e ${in_dir} ] || mkdir -p ${in_dir} && $green"创建安装目录${in_dir}"$end
    if [ $? -eq 0 ];then
        echo ${Separator}
        $green"开始编译安装zabbix-agent客户端"$end
        echo ${Separator}
        echo 
        tar -xvf ${soft_dir}/zabbix-4.0.21.tar.gz -C ${soft_dir}>/dev/null && cd ${soft_dir}/zabbix-4.0.21
        if [ $pcre_vs -le 8 ];then
        
             ./configure  --prefix=/opt/zabbix-agent/ -with-libpcre=/usr/local/pcre  --enable-agent  >/dev/null
        else
             ./configure  --prefix=/opt/zabbix-agent/  --enable-agent  >/dev/null
        fi
        make >/dev/null && make install >/dev/null
        if [ $? -eq 0 ];then
            echo ${Separator}
            $green"编译成功，开始启动服务....."$end
            echo ${Separator}
            echo 
          else
            $red"请查看输出的编译错误"$end
            exit 1
        fi
    fi
    cd ${soft_dir}/zabbix-4.0.21
    [ -e ${soft_dir/etc} ] && cp -r ${soft_dir}/etc /opt/zabbix-agent ||$red"配置文件不存在" $end
    mkdir /opt/zabbix-agent/scripts
    cp  -r $soft_dir/scripts/*  $in_dir/scripts && echo "执行脚本复制成功"
    $green"开始启动zabbix-agent"$end
    echo 
    /opt/zabbix-agent/sbin/zabbix_agentd && action "zabbix-agent 启动"
    


}

sudo -n true
if [ $? -eq 0 ];then
   out
   test
else 
   echo "用户权限不足"
   exit 0
fi

##while :;do
###install_pcre
###install_agent
##if [ ${pcre_vs} -ge 8 ];then
##   echo "${pcre_vs}"
##   #install_pcre
##   install_agent
##else 
##    ${red}"pcre版本不足，退出安装,查看sudo权限"${end}
##    break
##fi
##
##pcre_vs=7
##
##done



