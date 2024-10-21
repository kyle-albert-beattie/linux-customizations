#!/bin/bash
# Dependencies: find, geany
# Description:
# This script will run a shellcheck on all the files in the given directory.
echo "Where are the bash scripts located?"
read -r dir
cd "$dir" || exit
# This command uses find to search for all files (-type f) in the current directory and its subdirectories. The ! -path "./.git/*" part excludes files in the .git directory. The head -n 1 command is used to check if the first line of the file contains the string "bin/bash" or "bin/sh".
find . -type f ! -path "./.git/*" -exec sh -c 'head -n 1 {} | egrep -a "bin/bash|bin/sh" >/dev/null' \; -print -exec shellcheck {} \; > log-shellcheck.txt
geany log-shellcheck.txt
