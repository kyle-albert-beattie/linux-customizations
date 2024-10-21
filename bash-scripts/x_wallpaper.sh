#!/bin/bash
# Dependencies: xargs xwallpaper

# Description: This script runs automatically upon starting qtile and
# changes the wallpaper automatically every 5 minutes.

pics="/home/kyle/Pictures/wallpapers/minimal/"
curdesk0=$(find $pics -type f | shuf -n 1)
echo "$curdesk0" | xargs xwallpaper --stretch &
wal -i "$curdesk0" &
OLD_PID=$!
while true; do
    sleep 600
    curdesk1=$(find $pics -type f | shuf -n 1)
    echo "$curdesk1" | xargs xwallpaper --stretch
    NEXT_PID=$!
    sleep 1
    kill $OLD_PID
    wal -i "$curdesk1"
    NEXT_PID=$!
    OLD_PID=$NEXT_PID
done
