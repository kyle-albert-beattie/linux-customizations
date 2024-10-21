#!/bin/bash
# Description: This script will move all files recursively in a folder to the parent folder.
# This is the root directory where all the folders of files are that you wish you to move
echo "What directory are the files in?"
# This saves the root directory as a variable called "loc"
read -r loc
cd "$loc" || exit
# For loop that runs through all folders and renames files within, change the last number to the correct one
for file in **/*; 
	do mv "$file" .; 
done
