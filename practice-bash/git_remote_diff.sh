#!/bin/bash

url=$1
branch1=$2
branch2=$3
work_dir=$(pwd)
script_dir=$(dirname "$(realpath "$0")")
project_dir="$script_dir/.project"
diff_file="$script_dir/diff.txt"

git clone -b "$branch1" -- "$url" "$project_dir" && \
cd "$project_dir" && \
git fetch origin "$branch2" && \
git diff origin/"$branch2" > "$diff_file" && \
cd "$work_dir" && \
rm -rf "$project_dir"
