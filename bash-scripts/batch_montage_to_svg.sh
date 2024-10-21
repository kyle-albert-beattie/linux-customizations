#!/bin/bash

# BATCH MONTAGE IMAGE TO SVG
# Author: Kyle Beattie 26-05-2022
# Dependencies: pipx install cairosvg
# Other Dependencies: inkscape, rsvg

# Description:
# This script will convert image files to a montaged SVG as a 2x5 grid of images without losing quality.
# Details on cairosvg can be found here: https://cairosvg.org/

# Check if there are arguments supplied, if not ask the user to supply the argument, otherwise proceed with any argument that has already been supplied.
[ $# -eq 0 ] &&
# This will ask the user what directory the images are in
echo What directory are the images in? &&
# This will obtain the input from the user of the directory location and save it as a variable
read img_loc &&
# This will relocate the operating directory to the proper input
cd $img_loc
# This will relocate the operating directory to the input argument if supplied by the user during the original bash command
cd $1
# Make sure names do not have any spaces
rename "s/ /_/g" *
# Use Montage from ImageMagick to align all images in a 2x5 grid pattern with 
montage -tile 2x5 -geometry 3052x1576+4+4 -page letter `ls -v *` MontagedPDF.svg
   # Announce this step to the user
   #echo "Images Converted and addded to Combined_PDF.pdf"
   # Reduce the size of this large pdf
   #gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressedCombined_PDF.pdf Combined_PDF.pdf
   # Remove large size pdf
   #rm Combined_PDF.pdf
exit 
