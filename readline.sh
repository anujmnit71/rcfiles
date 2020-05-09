#!/bin/sh
filename=$1
out=lognslookup.txt
echo "" >$out
while read line; do
    echo "------------------------------------------" >>$out
    echo $line
    echo $line>>$out
    nslookup "$line" >>$out
    ping "$line" >>$out
done <$filename
