#!/usr/bin/env bash 

#COLORSCHEME=DoomOne

### AUTOSTART PROGRAMS ###
/home/kyle/bin/set-monitors.sh &
xsession &
xcompmgr &
picom &
/usr/bin/kdeconnect-app &
/usr/bin/kdeconnect-indicator &
nm-applet &
/usr/bin/lxpolkit &
/usr/bin/emacs --daemon &
/home/kyle/bin/x_wallpaper.sh &
/home/kyle/bin/greeting.sh &

#find /home/kyle/Pictures/4K-landscapes/ -type f | shuf -n 1 | xargs xwallpaper --stretch

#nm-applet &
#"$HOME"/.screenlayout/layout.sh &
#sleep 1
#conky -c "$HOME"/.config/conky/qtile/01/"$COLORSCHEME".conf || echo "Couldn't start conky."

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
#xargs xwallpaper --stretch < ~/.cache/wall &
# 2. Uncomment to set a random wallpaper on login
# 3. Uncomment to set wallpaper with nitrogen
# nitrogen --restore &

