#!/bin/bash

# BATCH CONVERT PDF TO PNG
# Author: Kyle Beattie 26-05-2022
# Dependencies: pipx install cairosvg
# Other Dependencies: inkscape, rsvg

# Description:
# This script will convert PDF files to png files without losing quality.
# Details on cairosvg can be found here: https://cairosvg.org/

# This will ask the user what directory the images are in
echo What directory are the PDFs in?
# This will obtain the input from the user of the directory location and save it as a variable
read -r pdf_loc
# This will relocate the operating directory to the proper input
cd "$pdf_loc" || exit
# For loop to go through each photo in the specified directory
for pdf in *; do
# Export image as pdf with standard inputs
	convert "$pdf" "${pdf%.*}.png"
		# This announces what image is being converted as the  loop progresses
        echo "image ""$pdf"" converted to ""${pdf%}"".png"
done
exit 
