#!/bin/bash
# Description: This script will change the font automatically in the
# qtile config file that accompanies these scripts.
# Dependencies: qtile font-config

# Specify the file path of the config file
FILE_PATH="/home/kyle/.config/qtile/config.py"
# Specify the file path of the backup config file
BFILE_PATH="/home/kyle/Documents/qtile-config-backup.py"
# Specifcy the file path of the fonts list file
FONTS_LIST="/home/kyle/fonts-list.txt"
# Backup your preivous working qtile config (use this if you have errors)
cp $FILE_PATH $BFILE_PATH
# Obtain a list of fonts on this system and port th
fc-list : family | sort > $FONTS_LIST
# Specify the line in the qtile config to change
line=44
# Specify a random font from the list
font=$(shuf -n 1 $FONTS_LIST)
# Specify the line to insert in the qtile config
line_to_insert="font = "\""$font"\"""
# Insert the line in the qtile config
text=$line_to_insert awk -i inplace -v lineno="$line"     'NR == lineno { print ENVIRON["text"]; next }; 1' "$FILE_PATH"
