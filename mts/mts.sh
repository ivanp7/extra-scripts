#!/bin/sh

exec sudo wvdial --config "$(dirname $0)/aux/wvdial.conf" HuaweiMTS

