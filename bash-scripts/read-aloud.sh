#!/bin/bash
# This script will read aloud any file.
# Dependencies: ebook-convert, pandoc, pdfinfo
# Piper models
piper_model="/home/kyle/Downloads/en_US-lessac-medium.onnx"
piper="/home/kyle/Downloads/piper_amd0064/piper/piper"
txt="/home/kyle/Documents/readaloud.txt"
# Ask user what file to read aloud.
echo "What file would you like to read aloud?"
# Obtain file location from user input
read "file"
# Check if file is a pdf, if it is convert it to txt
# then play it
if pdfinfo "$file" &> /dev/null; then
  # convert pdf to txt file
  ebook-convert "$file" "$txt"
  # read in txt file data
  readaloud=$(cat $txt) &&
  # play file aloud
  echo "$readaloud" | $piper \
	--model $piper_model \
	--output-raw | aplay -r 22050 -f S16_LE -t raw
  # exit the program once this finishes
exit
# If the file is not a PDF then send it to pandoc to try
# and convert it to a txt file
fi &&
# convert other files (.docx,.md,.html. etc.) to txt
pandoc "$file" -o $txt &&
# read in txt file data
readaloud=$(cat $txt) &&
# play file aloud
echo "$readaloud" | $piper \
	--model $piper_model \
	--output-raw | aplay -r 22050 -f S16_LE -t raw
