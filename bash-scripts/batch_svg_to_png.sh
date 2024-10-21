#!/bin/bash

# BATCH CONVERT SVG TO PNG
# Author: Kyle Beattie 26-05-2022
# Dependencies: pipx install cairosvg
# Other Dependencies: inkscape, rsvg

# Description: 
# This script will convert svg files to png files without losing quality.
# Details on cairosvg can be found here: https://cairosvg.org/

# This will ask the user what directory the images are in
echo What directory are the images in?
# This will obtain the input from the user of the directory location and save it as a variable
read -r img_loc
# This will relocate the operating directory to the proper input
cd "$img_loc" || exit
# This will loop through each image and change its transparency and then rename it accordingly
echo "Would you like to use 'inkscape', 'cairo' or 'rsvg'? Please type your choice. FYI: 'cairo' and 'inkscape' do really well with most SVGs with 'inkscape' often being higher quality in my experience. 'rsvg' can help if certain characters are not rendering properly."
# This will record the choice of the user.
read -r svgtype
# For loop to go through each photo in the specified directory
for image in *.svg; do
# If the user chose cairo, use cairosvg
	if [ "$svgtype" = 'cairo' ]; then
# Export svg as png with standard inputs
	cairosvg "$image" -o "${image%.*}.png"
		# This announces what image is being converted as the  loop progresses
        echo "image ""$image"" converted to ""${image%}"".png"
fi
# If the user chose rvsg, use rvsg
	if [ "$svgtype" = 'rsvg' ]; then
# Export svg as png with DPI=1000	
	rsvg-convert -a -f Png -d 1000 -p 1000 -o "${image%.*}.png" "$image"
		# This announces what image is being converted as the  loop progresses
        echo "image ""$image"" converted to ""${image%}"".png"
fi
# If the user chose inkscape, use inkscape
	if [ "$svgtype" = 'inkscape' ]; then
# Export svg as png with DPI=1000	
	inkscape --export-dpi=1000 --export-filename="${image%.*}.png" "$image"
		# This announces what image is being converted as the  loop progresses
        echo "image ""$image"" converted to ""${image%}"".png"
fi
done
exit 
