#!/bin/sh

TIME=$1
[ -z "$TIME" ] && exit 1

echo -n "Skype: "
SKYPE_ID=$(choose-node-id.sh)
[ -z "$SKYPE_ID" ] && exit 1
echo "$SKYPE_ID"

echo -n "Telegram: "
TELEGA_ID=$(choose-node-id.sh)
[ -z "$TELEGA_ID" ] && exit 1
echo "$TELEGA_ID"

echo "DISPLAY=$DISPLAY $(dirname $0)/utro_na_rabote.sh $SKYPE_ID $TELEGA_ID" | at $TIME

