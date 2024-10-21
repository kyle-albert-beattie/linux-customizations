#!/bin/bash
# BATCH CONVERT PDF TO TXT
# Author: Kyle Beattie 09-09-24
# Dependencies: pdftotext

# Description:
# This script will convert PDF files to png files without losing quality.
# Details on cairosvg can be found here: https://cairosvg.org/

# This will ask the user what directory the images are in
echo What directory are the PDFs in?
# This will obtain the input from the user of the directory location and save it as a variable
read -r pdf_loc
# This will relocate the operating directory to the proper input
cd "$pdf_loc" || exit
# LOOP AND UNITE: This will loop through each folder and convert each pdf to txt
for folder in $(ls); do
# Go to the current folder 
cd "$folder"                            
    for pdf in *.pdf; do
# Export image as pdf with standard inputs
	pdftotext -layout "$pdf" "$pdf.txt"
        # This announces what image is being converted as the  loop progresses
        echo "folder ""$folder"" converted to ""$pdf_locs""/""$folder"".txt"
        done
	cd ..
done
exit 
