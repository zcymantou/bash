#!/bin/bash
#
#********************************************************************
#Author:            zhuangCY
#QQ:                2362244529
#Date:              2021-08-15
#FileName：         LVS_ipvs.sh
#URL:               http://
#Description：      The test script
#Copyright (C):    2021 All rights reserved
#********************************************************************
RED='echo -e \033[031m'
GREEN='echo -e \033[032m'
YELLOW='echo -e \033[033m'
BLUE='echo -e \033[036m'
END='\033[0m'

VIP=10.0.0.240

case $1 in
start)
    /sbin/ifconfig lo:0 $VIP netmask 255.255.255.255 broadcast $VIP
    /sbin/route add -host $VIP dev lo:0
    echo 1 > /proc/sys/net/ipv4/conf/lo/arp_ignore
    echo 2 > /proc/sys/net/ipv4/conf/lo/arp_announce
    echo 1 > /proc/sys/net/ipv4/conf/all/arp_ignore
    echo 2 > /proc/sys/net/ipv4/conf/all/arp_announce
    sysctl -p >/dev/null 2>$1
    ;;
stop)
   /sbin/ifconfig lo:0 down
   /sbin/route del $VIP >/dev/null 2>$1
   echo 0 > /proc/sys/net/ipv4/conf/lo/arp_ignore
   echo 0 > /proc/sys/net/ipv4/conf/lo/arp_announce
   echo 0 > /proc/sys/net/ipv4/conf/all/arp_ignore
   echo 0 > /proc/sys/net/ipv4/conf/all/arp_announce
   ;;

*)
    exit 1
esac 
