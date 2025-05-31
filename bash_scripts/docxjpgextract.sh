#!/bin/bash
# Extract jpg images from a collection of docx
# author: Prof. Aaron M. Johnson

if [ "$1" = "" ]; then
 echo "Extract jpg images from a collection of docx"
 echo "usage: `basename $0` <docx file list>"
 echo "output: images in same location"
 exit
fi
mkdir _tmp
for ARG in "$@"; do
#    echo "${ARG%.*}"
    unzip "$ARG" word/media/* -d _tmp
    for IMG in _tmp/word/media/*; do
#        echo "$(basename "$IMG")"
        cp "$IMG" "${ARG%.*}_$(basename "$IMG")"
    done
    rm -rf _tmp/*
done
rm -rf _tmp
