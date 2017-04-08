#!/bin/bash
#P3のログから発言数の多いidランキングを生成する

#post数表示
post=`cat $1 | nkf | sed "1d" | sed "/^[^2]/d" | wc -l $1 | awk {'print $1'}`
post=$post

list=`cat $1 | nkf | sed "1d" | sed "/^[^2]/d" | awk {'print $3'} | sort | uniq -c | sort -r`
mem=`echo "$list" | wc -l`

echo "$list"
echo "${post}:ports / ${mem}:username"
