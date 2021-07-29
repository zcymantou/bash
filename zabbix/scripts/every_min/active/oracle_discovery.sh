#!/bin/bash
INST_ID=`cat /tmp/active.log|awk '{print $1}'|awk 'NR>3{print}'`
COUNT=`echo "$INST_ID"|wc -l`
INDEX=0
echo '{"data":['
echo "$INST_ID" | while read LINE; do
    echo -n '{"{#INST_ID}":"'$LINE'"}'
    INDEX=`expr $INDEX + 1`
    if [ $INDEX -lt $COUNT ]; then
        echo ','
    fi
done
echo ']}'

