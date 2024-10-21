#!/bin/bash
# Description:
# This script will copy all files in subdirectories to the parent directory.
echo "What directory's files do you need to move to the parent folder?"
read -r dir1
cd "$dir1" || exit
find . -mindepth 2 -type f -print -exec mv --backup=numbered {} . \;
