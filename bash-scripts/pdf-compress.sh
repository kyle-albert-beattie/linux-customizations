#!/bin/bash
# Dependencies: ghostscript

# Description:
# This script will compress a PDF file to a smaller size while still keeping it readable.

echo "What pdf do you want to compress?"
read -r in
dir=$(dirname "$in")
filename=$(basename "$in")
cd "$dir" || exit
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/screen -dQUIET -q -o "compressed_${filename}" "${filename}"

