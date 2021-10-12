#!/bin/bash

set -e

launcher_script_dir=$(dirname "$(realpath "$0")")
daemon_script_file=$launcher_script_dir/write_mem_daemon.sh
processInfoDir=$launcher_script_dir/.process_info

startScript() {
  if [ ! -d "$processInfoDir" ]; then
    mkdir "$processInfoDir"
  fi
  if [ -f "$processInfoDir"/pid ]; then
    childPid=$(cat "$processInfoDir"/pid)
      if ps -p "$childPid" >/dev/null; then
        echo "daemon is already running"
        exit 0
      fi
  fi
  $daemon_script_file &
  childPid=$!
  echo "parent pid $$"
  echo "child pid $childPid"
  echo $childPid >"$processInfoDir"/pid
}

if [ "$1" = "START" ]; then
  startScript
elif [ "$1" = "STOP" ]; then
  if [ ! -f "$processInfoDir"/pid ]; then
    echo "daemon is not running"
    exit 0
  fi
  pid=$(cat "$processInfoDir"/pid)
  kill -SIGTERM "$pid"
else
  if [ ! -f "$processInfoDir"/pid ]; then
    echo "daemon is not running"
    exit 0
  fi
  childPid=$(cat "$processInfoDir"/pid)
  if ps -p "$childPid" >/dev/null; then
    echo "daemon is running"
  else
    echo "daemon is not running"
  fi
fi
