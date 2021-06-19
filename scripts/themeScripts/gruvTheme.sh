#!/bin/bash
#find random wallpaper from ~/wallpapers and set it as wallpaper using pywal
if [ -z "$1" ]
then
    echo "usage: $0 [path/to/images] [image_name (if none choose random)]"
    exit 1
else
    if [ -z "$2" ]
    then
         ls $1 |sort -R |tail -1 |while read file; do
            wal -q -i $1/$file
        done
    else
        wal -q -i $1/$2
    fi
fi

sudo yabai --load-sa
