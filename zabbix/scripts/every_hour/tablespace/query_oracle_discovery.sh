source /home/oracle/.bash_profile
sqlplus -S "dbsnmp/xxxxxx"  > /tmp/tablespace.log<<EOF
set feedback off
set linesize 200
set pagesize 100
select t.tablespace_name,t.total_mb,t.free_mb,t.used_mb from sfdba.v_zabbix_spsize t;
EOF
