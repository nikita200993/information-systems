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
  used=$(echo "$line" | sed '2q;d')
  usage=$(((used * 100) / total))
  time=$(date -u +%m-%d-%Y%Z%T)
  echo "$time;$total;$used;$usage" >> $file
  sleep 600
done