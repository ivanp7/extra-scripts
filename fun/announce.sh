#!/bin/sh

DIRECTORY=/mnt/data/media/audio/sounds/announcer

cd $DIRECTORY
find . -type f | dmenu -fn "$DEFAULT_FONT" -l 10 -i | 
    xargs -I {} mpv --no-terminal "{}" &

