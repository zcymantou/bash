#!/bin/bash
INSTANCE_NUMBER=`cat /tmp/dbtime.log|awk '{print $1}'|awk 'NR>3{print}'`
COUNT=`echo "$INSTANCE_NUMBER"|wc -l`
INDEX=0
echo '{"data":['
echo "$INSTANCE_NUMBER" | while read LINE; do
    echo -n '{"{#INSTANCE_NUMBER}":"'$LINE'"}'
    INDEX=`expr $INDEX + 1`
    if [ $INDEX -lt $COUNT ]; then
        echo ','
    fi
done
echo ']}'


