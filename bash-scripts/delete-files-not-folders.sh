#!/bin/bash
# Description:
# This script will delete all the files in all the directories within the given directory without deleteing the directories themselves.
echo "What directory's files would you like to delete without deleting the directories?"
read -r dir
find "$dir" -type f -exec rm {} \;
