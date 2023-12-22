#!/bin/bash
# Compress a PDF to be a little smaller
# author: Prof. Aaron M. Johnson
# Adapted from: https://askubuntu.com/questions/113544/how-can-i-reduce-the-file-size-of-a-scanned-pdf-file

if [ "$1" = "" ]; then
 echo "Compress a PDF to be a little smaller"
 echo "usage: `basename $0` <file.pdf> [resolution]"
 echo "resolution options: /screen /ebook /prepress /printer /default"
 echo "output: file_sm.pdf"
 exit
fi

pdf_input=$1
pdf_output=${pdf_input%.*}_sm.pdf

# Resolution options:
# /screen lower quality, smaller size. (72 dpi)
# /ebook for better quality, but slightly larger pdfs. (150 dpi)
# /prepress output similar to Acrobat Distiller "Prepress Optimized" setting (300 dpi)
# /printer selects output similar to the Acrobat Distiller "Print Optimized" setting (300 dpi)
# /default selects output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file



if [ "$2" = "" ]; then
 resolution="/printer"
else
 resolution=$2
fi

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=${resolution} -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${pdf_output}"   "${pdf_input}"
