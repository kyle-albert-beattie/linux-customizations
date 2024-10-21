#!/bin/bash
# WGET DOWNLOADER WITH HEADER
# Author: Kyle Beattie 2021
# Dependencies: pdftk pdftotext ots kdeconnect wget mapfile

echo "What is the location of the .txt file with multiple URLs?" # Put the location here exactly of the .txt file
read -r txt_loc # Make it a variable
mapfile -t URLs < "$txt_loc" # Make an array from the txt file, here the array is: URLs

echo "Where do you want the files downloaded to?" # Put here the location where you want the files to download
read -r dl_loc # Make it a variable
cd "$dl_loc" || exit

while IFS= read -r line; do  # Read each line
wget --header='Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' "$line";  # Execute wget at each line with header
echo "#### DOWNLOADING IN PROGRESS #### <-- Specifically, I am working on URL --> " "$line"; # Progress Bar
done < "$txt_loc" # Txt file array



