#!/bin/bash

fin="$1"
fout="$2"

rm "$fout"
#while read line; do
#        newstr=$(echo $line | perl -pe 's/\s{2,}/,/g')
#        newstr=`sed 's/\t/,/g'`
#        printf "in: ${line} \nout: ${newstr} \n\n"
#        echo $newstr >> $fout
#done < $fin

# This was the way it used to work
# Just one line changed entire file
# But it doesn't work anymore...
#sed 's/\t/,/g' $fin >> $fout
sed 's/\s\{2,4\}/,/g' "$fin" >> "$fout"
