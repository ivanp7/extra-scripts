#!/bin/sh

SKYPE_NODE_ID=$1
TELEGRAM_NODE_ID=$2

[ -z "$SKYPE_NODE_ID" ] && exit 1
SKYPE_WINDOW_ID=$(bspc query -T -n $SKYPE_NODE_ID | jq ".id")

xdotool mousemove --clearmodifiers --sync 120 345
sleep 0.1
xdotool click --clearmodifiers --repeat 3 --window $SKYPE_WINDOW_ID 4
sleep 0.5
xdotool click --clearmodifiers --window $SKYPE_WINDOW_ID 1
sleep 1
xdotool mousemove --clearmodifiers --sync 770 1035
sleep 0.1
xdotool click --clearmodifiers --window $SKYPE_WINDOW_ID 1
sleep 0.5

xdotool key --clearmodifiers --window $SKYPE_WINDOW_ID Cyrillic_de Cyrillic_o Cyrillic_be Cyrillic_er Cyrillic_o Cyrillic_ie space Cyrillic_u Cyrillic_te Cyrillic_er Cyrillic_o
sleep 0.5
xdotool key --clearmodifiers --window $SKYPE_WINDOW_ID Return
sleep 1

[ -z "$TELEGRAM_NODE_ID" ] && exit 1
bspc node $TELEGRAM_NODE_ID --focus

