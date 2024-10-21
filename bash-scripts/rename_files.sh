#!/bin/bash
# Description: This script will rename all files recursively in a folder.
# This is the root directory where all the folders of files are that you wish you to rename
echo "What directory are the files in?"
# This saves the root directory as a variable called "loc"
read -r loc
echo "What string do you want to remove?"
read -r old_string
echo "What string do you want to insert in its place?"
read -r new_string
cd "$loc" || exit
# For loop that runs through all folders and renames files within, change the last number to the correct one
for i in */;
do
  cd /"$loc"/"$i" || exit
  echo "Processing..." "$i"
  # This is the rename function with the following syntax 's|remove this|replace with this|g'
  rename "s/$old_string/_/$new_string" -- *
done
