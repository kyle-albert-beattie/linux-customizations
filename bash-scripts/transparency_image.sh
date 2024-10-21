#!/bin/bash
# IMAGE TRANSPARENCY MAKER
# Author: Kyle Beattie 26-05-2022
# Dependencies: sudo apt-get install imagemagick

# This script will make any folder of images into images with the desired transparency level.
# This script can be utilized to make transparent the variant images copied from : https://covariants.org/per-country

# This will ask the user what directory the images are in
echo "What directory are the images in?"
# This will obtain the input from the user of the directory location and save it as a variable
read -r img_loc
# This will relocate the operating directory to the proper input
cd "$img_loc" || exit
# This will loop through each image and change its transparency and then rename it accordingly
for image in *.png; do
	# This will add a level of transparency to the image equal to the number below (0,38%)
	# This will also rename the image as desired simply change the (38-)  to add an desired prefix to the new image title
	convert  "$image" -matte -channel A +level 0,38% +channel "38-${image%.png}"
	# This announces what image is being converted as the  loop progresses
    echo "image ""$image"" converted to ""${image%38.png}"""
done
exit 
