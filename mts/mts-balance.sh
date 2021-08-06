#!/bin/sh

cd $(dirname $(realpath $0))
. aux/ussd.sh

USSD_REQUEST="*100#"
echo "===> $USSD_REQUEST <==="

ENCODED_REQUEST=$(encode "$USSD_REQUEST")
echo "Sending request to $MODEM_INPUT_DEVICE"
write_query "$ENCODED_REQUEST"

echo "Waiting for response from $MODEM_OUTPUT_DEVICE"
ENCODED_RESPONSE=$(read_response)

RESULT=$(decode $ENCODED_RESPONSE | head -n1 | sed 's/\s*Reklama.*//')
echo "===> $RESULT <==="
notify-send "$RESULT"

