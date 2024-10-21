#!/bin/bash

# Dependencies: pdfunite

# Description:
# This script will recursively search though folders in a folder and join all the pdfs in them into one.

# This will ask the user what directory the pdfs are in
echo What directory are the folders of the pdfs in?
# This will obtain the input from the user of the directory location and save it as a variable
read -r dir_loc
# This will relocate the operating directory to the proper input
cd "$dir_loc" || exit
# LOOP AND UNITE: This will loop through each folder and join each the pdfs into one pdf
for folder in $(ls -- *); do
        # Go to the current folder
        cd "$dir_loc/$folder" || exit;
        # This will join all pdfs in the current folder
        pdfunite -- * "$dir_loc/$folder.pdf";
        # This will also rename the pdf as desired simply change the (38-)  to add an desired prefix to the new image title
        #cairosvg -d 160 -o "${image%.*}.png" "$image"
        # This announces what image is being converted as the  loop progresses
        echo "folder ""$folder"" converted to ""$dir_loc""/""$folder"".pdf"
done

# FINAL UNITE: This will join all the united pdfs that were created from each folder into one final pdf
cd "$dir_loc" || exit
pdfunite -- * "pdfuniteFINAL.pdf"

exit

