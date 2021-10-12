#!/bin/bash

daemon_script_dir=$(dirname "$(realpath "$0")")
csv_file=$daemon_script_dir/mem.txt

if [ ! -f "$csv_file" ]
then
  echo "timestamp;all_memory;free_memory;%usaged" > "$csv_file"
fi

while true
do
  line=$(free -m | grep "^Mem:.*$" | awk '{print $2;print $3;}')
  total=$(echo "$line" | sed '1q;d')
  used=$(echo "$line" | sed '2q;d')
  usage=$(((used * 100) / total))
  time=$(date -u +%m-%d-%Y%Z%T)
  echo "$time;$total;$used;$usage" >> "$csv_file"
  sleep 600
done