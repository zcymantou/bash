source /home/oracle/.bash_profile
sqlplus -S "dbsnmp/xxxxxx" >/tmp/active.log <<EOF
set feedback off
select t.inst_id,t.active_cn from sfdba.v_zabbix_active t;
EOF





