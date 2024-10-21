#!/bin/bash
# Description: This script will create a file of the desired name in the desired directory.
echo "In which directory do you want to create this file?"
read -r location
echo "What should the name of the file be?"
read -r name
cd "$location" || exit
test -e "$name" || echo > "$name"
gedit "$name"
