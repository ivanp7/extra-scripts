#!/bin/sh

if [ -n "$1" ]
then DOWNLOAD_SPEED=$1
else DOWNLOAD_SPEED=2048
fi

if [ -n "$2" ]
then UPLOAD_SPEED=$2
else UPLOAD_SPEED=$DOWNLOAD_SPEED
fi

sudo netctl start mts
sleep 12
# sudo wondershaper -a ppp0 -d $DOWNLOAD_SPEED -u $UPLOAD_SPEED

notify-send -t 3000 "MTS Internet connected!"

