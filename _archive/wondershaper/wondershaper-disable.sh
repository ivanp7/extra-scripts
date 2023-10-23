#!/bin/sh

INTERFACE=${1:-ppp0}

sudo wondershaper -c -a $INTERFACE

