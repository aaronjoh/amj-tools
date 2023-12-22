#!/bin/bash
# Script to check for common problems in LaTeX files
# author: Prof. Aaron M. Johnson

echo 'This check will search for special characters, words, and repeated words that you may want to correct, however these may or may not 
be errors!'

if [ "$1" = "" ]; then
 echo "usage: `basename $0` <file> ..."
 exit
fi

origfiles=`ls "$@"`

mkdir __tmp
cp $origfiles __tmp/

cd __tmp

files=`ls`

for srcfile in `ls *tex`; do
	latexpand --empty-comments --keep-includes $srcfile > _$srcfile 2>/dev/null;
	mv _$srcfile $srcfile;
done
grep --color='auto' -P -n '[^\x00-\x7F]' $files || true
grep --color='auto' -P -n '\x22' $files || true	
grep --color='auto' -n 'naive' $files || true
grep --color='auto' -n 'will' $files || true
grep --color='auto' -n '\b\([[:alpha:]]\+\)\b \1\b' $files || true
grep --color='auto' -n -H '[pP]ages.\+[[:digit:]]-[[:digit:]]\+}' $files || true
grep --color='auto' -n -H '[vV]olume.\+[[:digit:]]-[[:digit:]]\+}' $files || true
grep --color='auto' -n -H '[nN]umber.\+[[:digit:]]-[[:digit:]]\+}' $files || true
grep --color='auto' -n -H '[bB]ooktitle.\+[[:digit:]]\+}' $files || true
grep --color='auto' -n -H '[jJ]ournal.\+[[:digit:]]\+}' $files || true
grep --color='auto' -n -e 'e\.g\. ' -e 'e\.g\.$$' $files || true
grep --color='auto' -n -e 'i\.e\. ' -e 'i\.e\.$$' $files || true
grep --color='auto' -n -e 'c\.f\. ' -e 'c\.f\.$$' $files || true
grep --color='auto' -n -e '{\\em ' -e'{ \\em ' -e '{  \\em ' -e '\\emph{ ' -e '\\emph{.* }' $files || true
grep --color='auto' -n -e '\\textit{' $files || true

cd ..
rm -rf __tmp
