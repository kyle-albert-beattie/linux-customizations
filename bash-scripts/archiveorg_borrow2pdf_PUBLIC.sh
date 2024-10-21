#!/bin/bash

# ARCHIVE.ORG BORROW2PDF
# Author: Kyle Beattie
# Dependencies: python3, pdfunite, ghostscript,
# archiveripper https://github.com/scoliono/archiveripper/tree/master

# Description:
# This script will archive any pdf from Archive.org that is available to borrow for 1 hour (it will not work for those PDFs available only to the blind).
# The script functions by using archiveripper to take a picture of each page of the desired book, save that picture to a folder, convert all pictures downloaded in this way to a PDF, and then finally by combining all of those PDFs into a single file.
# An account with your email and a unique password for archive.org must be obtained to use this script. They can be obtained here: https://archive.org/account/signup

# Variables
# Folder where final PDF should go
img_loc="$HOME/Downloads"
# Suffix for final PDF
cpdf='Combined_PDF.pdf'
# Log file
log="$HOME/bin/archiveorg_borrow2pdf_log.txt"
# Warning text
image_warning='Warning! You have had an image download error. Please run this program again and follow the instructions in the terminal.'
# Archive.org Email
email='your-archive-org@email.here'
# Archive.org Password
pass='YOUR-ARCHIVE-ORG-PASSWORD-HERE'

# Automatic Tasks
# Clear log file
: > "$log"

# UNCOMMENT TO LET USER CHOOSE DOWNLOAD DIRECTORY, I WANT TO GO STRAIGHT TO MY DOWNLOADS FOLDER PERSONALLY
# This will ask the user what directory the pages should be downloaded to
#echo What directory should the pages be downloaded to?
# This will obtain the input from the user of the directory location and save it as a variable
#read img_loc

# This will ask the user what the archive identifier is [the part after .../details/) (https://archive.org/details/naturalselection0000baje)
echo What is the archive identifer?
# This will obtain the input from the user for the archive identifer
read -r id_archive
echo "What is the author-year-title.pdf of this book? (USE THIS FORMATTING!!!)"
read -r title
echo "Would you like this script to automatically run the completed PDF through pdfsandwich in order to perform an OCR scan of all pages and produce a searchable PDF as well? (y/n)"
read -r ocr

# This will relocate the operating directory to the proper input
cd "$img_loc" || exit
# Download images
python3 "$HOME/bin/archiveripper/ripper.py" -u $email -p $pass "$id_archive" &&

# Archive.org will often interrupt your webscraping if the book you are downloading is over 200 pages. In that case, this will throw an error warning for the user and will prompt them to begin the download again with the correct instructions to begin from where the error occurred.
# This will log all image errors to the log file.
[[ "$(sed -n '1p' "$log")" =~ "Error: Image Download Interruption" ]] &&
 # This will relocate the operating directory to the proper input
  cd "$img_loc"/"$id_archive" &&
 # Alert user to the error
  echo "$image_warning" &&
 # Tell user how to restart the download from the same position where the error occurred
 echo "Restart this download: $id_archive using this title: $title" &&
 # TODO: The following command could be used to direct the python app to the next page to download automatically.
 # Obtain the next page where the follow-up download should begin. 
  LS1=$(ls -l | grep -v ^d | wc -l) &&
  echo "Start your next download with page: $LS1" &&
  # This will announce the warning verbally if your audio is turned to on to alert the user that this process has been interrupted.
  espeak-ng "$image_warning" &&
 exit ||
 
# This will relocate the operating directory to the proper input
cd "$img_loc"/"$id_archive" &&
# Clean up
# Make sure names have leading zeros, so they are presented in order
rename 's/\d+/sprintf("%04d",$&)/e' -- * &&
# For loop to go through each photo in the specified directory
for image in *; do
   # Check if a pdf version of this image has already been converted
   [ ! -f "${image%.*}.pdf" ] && 
        # Export image as pdf with standard inputs
	convert "$image" "${image%.*}.pdf" &&
		# This announces what image is being converted as the  loop progresses
        echo "image ""$image"" converted to ""${image%}"".pdf"
done &&
   # Join the pdfs together into one pdf
   pdfunite -- *.pdf Combined_PDF.pdf &&
   # Announce this step to the user
   echo "Images Converted and addded to Combined_PDF.pdf" &&
   # Reduce the size of this large pdf
   gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$title" $cpdf &&
   # Remove large size pdf
   # Announce this step to the user
   echo "Removing large file Combined_PDF.pdf" &&
   rm Combined_PDF.pdf &&
   # Announce this step to the user
   echo "Copying $title to Downloads" &&
   cp "$title" "$img_loc"/"$title" &&
   # Announce this step to the user
   echo "Removing all files from archive.org except your compressed PDF, which should now be in your Downloads folder. If it is not, something terrible has happened, please debug me." &&
   rm -r "${img_loc}"/"{$id_archive}" &&
   
   # Check user input for ocr scanning allowing for alterative spellings of the standard y
   if [[ $ocr == "y" || $ocr == "Y" || $ocr == "yes" || $ocr == "Yes" ]]; then
  # execute command or script 'x' if MY_VAR is equal to "y"
     echo "Now running the completed PDF through pdfsandwich, please stand by."
     pdfsandwich "$title" "$img_loc"/"$title"
   fi &&
   echo "Congratulations, you have sucessfully archived a borrowed book from archive.org!" ||
#exit ||
   echo "Ah shucks! Looks like you threw an error somewhere." 
