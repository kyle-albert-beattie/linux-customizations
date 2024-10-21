#!/bin/bash
# Source: https://askubuntu.com/questions/1283783/is-it-possible-to-set-transparency-per-window-in-ubuntu-20-04

# Dependencies: xprop

# Description: This script will offer the user the option to change the
# transparency of any window by putting in a value between 0-100,
# 0 being completely transparent, and then clicking the desired window.

read -p "Set transparency percentage ? [Enter for 100%]" mydectrans
# only accept 10 to 99, rest is considered 100
[[ "$mydectrans" != [1-9][0-9] ]] && mydectrans=100
# Convert decimal to 32bit hex representation
my32bhextrans=$(printf 0x%x $((0xffffffff * $((mydectrans)) / 100)))
# Execute the action
xprop -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "$my32bhextrans"
