#!/bin/bash
# Dependencies: 
# Piper: https://github.com/rhasspy/piper/blob/master/README.md

# Description:
# This script will provide a pleasant greeting for the user depending on the time of day that includes a summary of the time, date, weather, and recent mainstream and alternative news headlines. 
# In addition, the autostart.sh script for the included qtile window manager is set to run this script automatically when the user boots their system.

# Piper models
piper_model="/home/kyle/Downloads/en_US-lessac-medium.onnx"
piper="/home/kyle/Downloads/piper_amd0064/piper/piper"
# Time and date
hour=$(date +%H)
# If it is between 12AM and 12PM greet the user appropriately
if [ "$hour" -ge 0 ] && [ "$hour" -lt 12 ]; then
  greeting="Top of the morning to you"
# If it is between 12PM and 4PM greet the user appropriately
elif [ "$hour" -ge 12 ] && [ "$hour" -lt 20 ]; then
  greeting="I hope you are having a lovely and productive afternoon."
else
  greeting="May you have a wonderful evening."
fi
user=$USER
today=$(date '+%A %B %d %Y')
time=$(date '+%X')
weather=$(metar -d cyed | sed -n '6p;9p;14p;15p')
main_headlines=$(wget -q -O - 68k.news | grep h3 | head -n 5 | html2text | sed 's/\*/ /g' | tr -s _ ' ')
alt_headlines=$(wget -q -O - revolver.news | grep '</a>' | html2text | sed 's/\*/ /g' | tr -s _ ' ' | sed -n '32p;33p;34p;35p;36p;37p')
echo "$greeting $user. Allow me to provide you with your current summary report. The current date is, $today, and the current time is, $time. The current weather report is, $weather. Finally, the current mainstream news headlines include, $main_headlines and the alternative news headlines include $alt_headlines. May the Force Be with You! Live Long. And Prosper." | $piper --model $piper_model --output-raw | aplay -r 22050 -f S16_LE -t raw
exit
