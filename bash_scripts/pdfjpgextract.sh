#!/bin/bash
# Extract jpg images from a collection of pdfs
# author: Prof. Aaron M. Johnson

if [ "$1" = "" ]; then
 echo "Extract jpg images from a collection of pdfs"
 echo "usage: `basename $0` <pdf file list>"
 echo "output: images in same location"
 exit
fi

for ARG in "$@"; do
    echo "${ARG%.*}"
    pdfimages.exe -all "$ARG" "${ARG%.*}"
done
