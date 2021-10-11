#!/bin/bash

set -e

processInfoDir=.process_info

startScript() {
  if [ ! -d $processInfoDir ]; then
    mkdir $processInfoDir
  fi
  ./write_mem_daemon.sh &
  childPid=$!
  echo "parent pid $$"
  echo "child pid $childPid"
  echo $childPid >$processInfoDir/pid
}

if [ "$1" = "START" ]; then
  startScript
elif [ "$1" = "STOP" ]; then
  if [ ! -f $processInfoDir/pid ]; then
    echo "daemon is not running"
    exit 0
  fi
  pid=$(cat $processInfoDir/pid)
  kill -SIGTERM "$pid"
else
  if [ ! -f $processInfoDir/pid ]; then
    echo "daemon is not running"
    exit 0
  fi
  childPid=$(cat $processInfoDir/pid)
  if ps -p "$childPid" >/dev/null; then
    echo "daemon is running"
  else
    echo "daemon is not running"
  fi
fi
