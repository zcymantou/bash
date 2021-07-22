#!/bin/bash
#ansible all -m copy -a "src=/root/zcy/zabbix/zabbix_agentd dest=/etc/init.d/"
ansible all -m shell -a "[ -e //etc/init.d/zabbix_agentd ] && chkconfig --add /etc/init.d/zabbix_agentd"
