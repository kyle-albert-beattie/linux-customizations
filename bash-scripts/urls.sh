#!/bin/bash
# Dependencies: lynx, wget
# Description:
# This script will download all hyperlinks from a website.
echo "Where are you downloading these files to?"
read -r dwn_loc
mkdir -p "$dwn_loc"
cd "$dwn_loc" || exit
echo "What is the website's address?"
read -r url
lynx -dump -listonly "$url" | sed -e 's/.* //' | tee "$HOME/bin/urls.txt"
wget --no-check-certificate -t 4 -i "$HOME/bin/urls.txt"
