#!/bin/bash
# This script will make a window transparent at 85%
echo Set transparency from 0-100
read trans
xprop -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY \
 $(printf 0x%x $((0xffffffff * $trans / 100)))


