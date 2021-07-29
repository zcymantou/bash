#!/bin/bash
TABLESPACE=`cat /tmp/tablespace.log |awk '{print$1}'|awk 'NR>3{print}'`
COUNT=`echo "$TABLESPACE" |wc -l`
INDEX=0
echo '{"data":['
echo "$TABLESPACE" | while read LINE; do
    echo -n '{"{#TABLENAME}":"'$LINE'"}'
    INDEX=`expr $INDEX + 1`
    if [ $INDEX -lt $COUNT ]; then
        echo ','
    fi
done
echo ']}'


