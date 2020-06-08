#!/bin/sh

CLHS_PATH="/mnt/data/library/Materials/Programming/Documentation/HyperSpec"
CLHS_DATA="$CLHS_PATH/Data"
CLHS_MAP="$CLHS_DATA/Map_Sym.txt"

SYMBOL_FILE="$(sed -n '1~2p' "$CLHS_MAP" | tr 'A-Z' 'a-z' | 
    dmenu -p "Common Lisp symbol" -fn "$DEFAULT_FONT" -l 10 -i | 
    xargs -I {} grep -Fix -A 1 '{}' "$CLHS_MAP" | sed '1d')"
[ -n "$SYMBOL_FILE" ] || exit
CLHS_URL="$CLHS_DATA/$SYMBOL_FILE"

CLASS="tabbed-surf-clhs"

xidfile="/tmp/tabbed-surf-clhs.xid"

runtabbed() {
    tabbed -cw $CLASS -r 2 surf -e '' "$CLHS_URL" > "$xidfile" 2>/dev/null &
}

if [ ! -r "$xidfile" ];
then runtabbed
else
    xid=$(cat "$xidfile")
    xprop -id "$xid" > /dev/null 2>&1
    if [ $? -gt 0 ];
    then runtabbed
    else surf -e "$xid" "$CLHS_URL" > /dev/null 2>&1 &
    fi
fi

