#!/bin/bash
# Date: Oct 14, 2024
# This script will convert any video file to an .mp3 audio file.
# Dependencies: ffmpeg
read -p "What file would you like to convert to audio?" file
read -p "Would you like to make a copy of this audio file to go in your work-music folder? (y/n)" answer

# Extract base name of file
base="${file%.*}" 

# Create name of audiofile
audio="$base.mp3"

# Extract file name w/out path
nopath="${audio##*/}"

# Directory of work music
musdir="/home/kyle/Music/work-music/"
ffmpeg -i "$file" "$audio"
echo "Converting $file to $audio"
if [ "$answer" = "y" ]; then
	echo "Copying ${audio} to ${musdir}${nopath}"
	cp "$audio" "$musdir$nopath"
else
  echo "No copy requested."
  exit 1
fi
exit
