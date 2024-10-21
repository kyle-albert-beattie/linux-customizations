#!/bin/bash

# BATCH CONVERT SVG TO PNG
# Author: Kyle 26-05-2022
# Dependencies: pipx install cairosvg
# Other Dependencies: inkscape, rsvg

# Description:
# This script will convert svg files to png files without losing quality.
# Details on cairosvg can be found here: https://cairosvg.org/

# This will ask the user what directory the images are in
echo "What directory are the images in?"
# This will obtain the input from the user of the directory location and save it as a variable
read -r img_loc
# This will relocate the operating directory to the proper input
cd "$img_loc" || exit
# Make sure names have leading zeros, so they are presented in order
rename 's/\d+/sprintf("%04d",$&)/e' -- *
# For loop to go through each photo in the specified directory
for image in *; do
# Export image as pdf with standard inputs
	convert "$image" "${image%.*}.pdf"
		# This announces what image is being converted as the  loop progresses
        echo "image ""$image"" converted to ""${image%}"".pdf"
done
   # Join the pdfs together into one pdf
   pdfunite -- *.pdf Combined_PDF.pdf
   # Announce this step to the user
   echo "Images Converted and addded to Combined_PDF.pdf"
   # Reduce the size of this large pdf
   gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressedCombined_PDF.pdf Combined_PDF.pdf
   # Remove large size pdf
   rm Combined_PDF.pdf
exit 
