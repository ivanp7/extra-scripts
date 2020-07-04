#!/bin/sh

sudo wondershaper -c -a ppp0
sleep 1
sudo netctl stop mts

notify-send -t 3000 "MTS Internet disconnected!"

