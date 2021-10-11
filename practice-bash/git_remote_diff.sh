#!/bin/bash

url=$1
branch1=$2
branch2=$3

git clone -b $branch1 -- $url .project && \
cd ./.project && \
git fetch origin $branch2 && \
git diff origin/$branch2 > ../diff.txt && \
cd ../ && \
rm -rf .project
