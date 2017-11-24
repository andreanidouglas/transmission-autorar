#!/bin/sh
#set -x
WORK_DIR=/mnt/Media/sb_download/

files=$(find $WORK_DIR -name "*.rar" -printf "%P@"  ) 
count=0
IFS="@"
for file in $files; do
 
    directory=$WORK_DIR$(dirname $file)
    #echo -e "$file -- $directory" 
    extracted=$(find $directory -name "extracted")
    if [ -z $extracted ]; then
	echo #$file 
        echo /usr/bin/7z x \"$WORK_DIR$file\" -o\"$directory\" -y
        echo touch $directory\/extracted
    fi





    #echo $count
    #count=$(($count+1))
done
