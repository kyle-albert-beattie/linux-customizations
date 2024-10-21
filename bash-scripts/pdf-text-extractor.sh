#!/bin/bash
# This script will return all of the instances of X in a list of PDF files.

echo Where are the PDFs located?
read pdf_loc
#echo What text are you looking for?
#read text
#echo How many lines after this text do you want to capture?
#read lines

txtdoc="extracts.txt"

cd $pdf_loc
for pdf in `ls`; do
  pdftotext $pdf 
  echo "$pdf converted to txt"
done
touch $txtdoc
for txt in `ls`; do 
  # Extract date
  sed -n '/SM2-Semi-Monthly Salaried/,+2p' $txt >> $txtdoc
  # Extract Total
  sed -n '/TOTAL GROSS/,+1p' $txt >> $txtdoc
  echo "$txt extracted"
done
exit

