source /home/oracle/.bash_profile
sqlplus -S "dbsnmp/xxxxx"  > /tmp/disksize.log<<EOF
set feedback off
set pagesize 100
select t.name,t.total_gb,t.used_gb,t.free_gb from sfdba.v_zabbix_dgsize t;
EOF
