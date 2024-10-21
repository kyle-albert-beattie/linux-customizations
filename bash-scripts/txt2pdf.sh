#!/bin/bash
# This script will convert a txt file to a pdf file.
echo "What is the .txt file that you would like to convert to .pdf?"
read -r "in"
out="${in%.*}"
pandoc "$in" -o "$out.pdf"
