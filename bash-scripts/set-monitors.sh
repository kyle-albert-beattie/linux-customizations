#!/bin/sh
# This script sets the monitors correctly for my two monitor setup
xrandr --auto --output HDMI-0 --primary --mode 1680x1050 --left-of DP-0
xrandr --auto --output DP-0 --mode 1920x1080
