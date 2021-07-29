#!/bin/bash
NAME=`cat /tmp/disksize.log |awk '{print$1}'|awk 'NR>3{print}'`
COUNT=`echo "$NAME" |wc -l`
INDEX=0
echo '{"data":['
echo "$NAME" | while read LINE; do
    echo -n '{"{#DGNAME}":"'$LINE'"}'
    INDEX=`expr $INDEX + 1`
    if [ $INDEX -lt $COUNT ]; then
        echo ','
    fi
done
echo ']}'





