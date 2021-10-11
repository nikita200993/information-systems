#!/bin/bash

file=mem.txt

if [ ! -f $file ]
then
  echo "timestamp;all_memory;free_memory;%usaged" > $file
fi

while true
do
  line=$(free -m | grep "^Mem:.*$" | awk '{print $2;print $3;}')
  total=$(echo "$line" | sed '1q;d')
  free=$(echo "$line" | sed '2q;d')
  usage=$(((free * 100) / total))
  time=$(date -u +%m-%d-%Y%Z%T)
  echo "$time;$total;$free;$usage" >> $file
  sleep 6
done