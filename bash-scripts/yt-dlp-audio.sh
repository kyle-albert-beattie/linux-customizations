#!/bin/bash
# This is a script that will automatically prompt the user to download the audio of a video as an mp3 file.
echo "What is the URL of the video from which you would like to extract the audio?"
read url
cd "/media/kyle/4B/Music/mp3/"
yt-dlp -i --extract-audio --audio-format mp3 --audio-quality 0 $url
