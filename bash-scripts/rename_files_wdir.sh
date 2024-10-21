#!/bin/bash
# This script will add the directory to the beginning of each filename.
echo "This script will add the directory to the beginning of each filename."
echo "What directory's files would you like to rename?"
read -r dir
cd "$dir" || exit

for i in $(ls); do                        # runs through the 'items' in this dir                               
  if [ -d "$i" ]; then                      # if this is a dir
     fname=${i##*/}                 # pick up the dir name which will be used as prefix
     echo "$fname"                           
     cd "$i" || exit                                     # move into the dir       
     for z in *; do               # loop over files starting with test and fq extension
       echo "$z" 
       mv "$z" "${fname}_${z}"         # put the prefix to the file.               
     done                                        
     cd ..                                         
  fi                                              
done
