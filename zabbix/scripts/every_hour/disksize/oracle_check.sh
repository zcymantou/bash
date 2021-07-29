#!/bin/bash
DG_NAME="$1"
EQ_DATA="$2"
SOURCE_DATA=/tmp/disksize.log
case $2 in
  TOTAL_GB)
    grep -w "$DG_NAME" $SOURCE_DATA |awk '{print $2}';;
  USED_GB)
    grep -w "$DG_NAME" $SOURCE_DATA |awk '{print $3}';;
  FREE_GB)
    grep -w "$DG_NAME" $SOURCE_DATA |awk '{print $4}';;
  *)
    echo $ERROR_WRONG_PARAM; exit 1;;
esac
exit 0

