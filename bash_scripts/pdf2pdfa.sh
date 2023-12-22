#!/bin/bash
# Convert PDF to PDFA
# author: Prof. Aaron M. Johnson

if [ "$1" = "" ]; then
 echo "Convert a PDF to PDFA format"
 echo "usage: `basename $0` <file.pdf>"
 echo "output: file_PDFA.pdf"
 exit
fi

pdf_input=$1
pdfa_output=${pdf_input%.*}_PDFA.pdf


gs  -dPDFA   -dBATCH   -dNOPAUSE   -sColorConversionStrategy=UseDeviceIndependentColor   -sDEVICE=pdfwrite   -dPDFACompatibilityPolicy=2   -sOutputFile="${pdfa_output}"   "${pdf_input}"
