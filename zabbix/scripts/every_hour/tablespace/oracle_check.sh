#!/bin/bash
ZBX_REQ_DATA_TAB="$1"
EQ_DATA="$2"
SOURCE_DATA=/tmp/tablespace.log
case $2 in
  TOTAL_MB)
    grep -w "$ZBX_REQ_DATA_TAB" $SOURCE_DATA |awk '{print $2}';;
  FREE_MB)
    grep -w "$ZBX_REQ_DATA_TAB" $SOURCE_DATA |awk '{print $3}';;
  USED_MB)
    grep -w "$ZBX_REQ_DATA_TAB" $SOURCE_DATA |awk '{print $4}';;
  *)
    echo $ERROR_WRONG_PARAM; exit 1;;
esac
exit 0




