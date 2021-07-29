#!/bin/bash
INPUT_MACRO_VALUE="$1"

SOURCE_DATA=/tmp/active.log
LINE_NUM=`awk '{print $1}'  $SOURCE_DATA | sed -n "/${INPUT_MACRO_VALUE}/="`
VALUES=`awk 'NR==value1{print $2}' value1=$LINE_NUM  $SOURCE_DATA`

echo "$VALUES"
