#!/bin/bash
# Dependencies: imagemagick
# Description:
# This script will take a folder of images and turn them in to a gif at the desired framerate.
echo "What is the directory of the images you would like to convert in to a gif?"
read -r dir
echo "How may ticks per second would you like for this gif? 

This option is useful for regulating the animation of image sequences ticks/ticks-per-second seconds must expire before the display of the next image. The default is no delay between each showing of the image sequence. The default ticks-per-second is N=100 N/100.

Useful values here include 20, 40, and 80, which would put 0.2, 0.4, or a 0.8 second display of the image before it moves to the next image."
read -r fr
cd "$dir" || exit
convert -delay "$fr" -loop 0 -- *.png out"$fr".gif

