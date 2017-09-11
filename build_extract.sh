#!/bin/sh
#set -x
export TRANSMISSION_IP=192.168.1.3
export TRANSMISSION_PORT=9091

extract_script="$PWD/extract.sh"
touch $extract_script
chmod +x $extract_script

alias tr='transmission-remote $TRANSMISSION_IP:$TRANSMISSION_PORT'

torrents_count=$(tr -l | awk '{print $1}' | tail -2 | head -1)

for i in $(seq 1 $torrents_count); do
    is_torrent_empty=$(tr -t $i -i | grep Id)
    if [ -z "$is_torrent_empty" ]; then
        echo "Invalid Torrent"
    else
        torrent_root_path=$(tr -t $i -i | grep Location | cut -c13-)/$(tr -t $i -i | grep Name | cut -c9-)
            
        is_not_extracted=$(find "$torrent_root_path" -name extracted)
        if [ -z "$is_not_extracted" ]; then
            #files=$(find "$torrent_root_path" -name *.rar)
            files=$(tr -t $i -f | grep rar | cut -c35- | sed 's/ //')
            for file in $files; do
                echo "# Extracting $i"
                echo  7z x \"$(dirname "$torrent_root_path/$file")/$file -o\"$torrent_root_path\"
                echo touch \"$(dirname "$torrent_root_path/$file")/extracted\"
            done
        fi
    fi    
done
