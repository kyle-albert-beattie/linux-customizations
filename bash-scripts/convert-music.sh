#!/bin/bash
# Dependencies: ffmpeg
# Description: This script will convert a directory of video or audio files to mp3 files.
echo "Where is the location of the directory with the files you would like to convert to mp3?"
read -r dir
cd "$dir" || exit
mkdir outputs
for f in *; 
do ffmpeg -i "$f" -c:a libmp3lame "outputs/${f%.*}.mp3"; 
done
exit
