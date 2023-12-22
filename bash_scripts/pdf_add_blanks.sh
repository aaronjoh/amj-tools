#!/bin/bash
# Add a blank page after each page of a PDF
# Useful for creating templates of scanned double sided documents 
# (I use it for Gradescope)
# author: Prof. Aaron M. Johnson


DIR="$(dirname $0)"


if [ "$1" = "" ]; then
 echo "Add a blank page after every page of a PDF"
 echo "usage: `basename $0` <file.pdf>"
 echo "output: file_Template.pdf"
 echo "Assumes ${DIR}/blank.pdf exists"
 exit
fi

numPages=$(identify "$1" 2>/dev/null | wc -l | tr -d ' ')

PDFJAM_ARG=""
for i in $(seq 1 ${numPages}); do
  PDFJAM_ARG="${PDFJAM_ARG} $1 $i ${DIR}/blank.pdf 1 ";
done

pdf_input=$1
pdf_output=${pdf_input%.*}_Template.pdf

pdfjam -o ${pdf_output} --fitpaper true ${PDFJAM_ARG}
