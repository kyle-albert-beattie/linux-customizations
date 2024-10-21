#!/bin/bash
# .docx to PDF Batch Converter
# Author: Kyle Beattie 2020-21
# Dependencies: libreoffice
# Description: This script will convert a .docx file to a pdf
echo "Where are the .docx documents located?" # Put location of pdf without file name. Ex. /home/kyle/Downloads/IR-TO_TRANSFER/
read -r docx_loc
echo "I am moving to that location"
cd "$docx_loc" || exit
echo "I am getting a list of your documents..."
#ls `*.docx > names.txt`
# Turn titles into variables
#read readarray -t names < names.txt
for names in *.docx; do
	echo "I am converting " "$names" " at this very moment"
	lowriter --headless --convert-to pdf "$names"
done
echo "Your documents have been converted"
exit
