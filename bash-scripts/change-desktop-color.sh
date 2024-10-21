#!/bin/bash
# Description: This script will backup the current qtile config file 
# and then it will change the window border color automatically in the qtile config file 
# that accompanies these scripts.

# Specify the file path and the line number
file_path="/home/kyle/.config/qtile/config.py"
backup_file_path="/home/kyle/Documents/qtile-config-backup.py"

cp $file_path $backup_file_path
line=50
color=$(shuf -n 1 /home/kyle/websafe-colors.txt)
line_to_insert=""\""border_focus"\"" : "\""$color"\"","
text=$line_to_insert awk -i inplace -v lineno="$line"     'NR == lineno { print ENVIRON["text"]; next }; 1' "$file_path"
