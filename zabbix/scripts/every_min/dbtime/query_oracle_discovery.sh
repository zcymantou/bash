source /home/oracle/.bash_profile
sqlplus -S "dbsnmp/xxxxxx" >/tmp/dbtime.log <<EOF
set feedback off
select t.instance_number,t.dbtime from sfdba.v_zabbix_dbtime t;
EOF
