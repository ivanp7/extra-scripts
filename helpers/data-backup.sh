#!/bin/sh
echo "Edit & execute this script using edex.sh, deleting this line!"; exit 1

DATA_PATH="/mnt/data"

if [ -s "$DATA_PATH/changes.txt" ]
then
    echo "Error: $DATA_PATH/changes.txt is not empty, please update target directory tree and clear changes.txt"
    exit 1
fi

backup_cmd ()
{
    local prefix="$1"
    local object="$2"
    shift 2

    echo
    echo "================================================================"
    echo "] Backing up '$object' to $prefix"
    echo "................................................................"
    echo

    remote.py -o upload --rsync-opt="-auz" --rsync-opt="--mkpath" -l "$DATA_PATH/$object" -r "$prefix/$object" "$@"
}

downld_cmd ()
{
    local prefix="$1"
    local object="$2"
    shift 2

    echo
    echo "================================================================"
    echo "] Downloading '$object' from $prefix"
    echo "................................................................"
    echo

    remote.py -o download --rsync-opt="-auz" --rsync-opt="--mkpath" -l "$DATA_PATH/$object" -r "$prefix/$object" "$@"
}

###############################################################################

backup1 ()
{
    local disk="$1"
    local object="$2"
    shift 2

    backup_cmd "/mnt/$disk/data" "$object" -h "home-1" -u "ivanp7" "$@"
}

download1 ()
{
    local disk="$1"
    local object="$2"
    shift 2

    downld_cmd "/mnt/$disk/data" "$object" -h "home-1" -u "ivanp7" "$@"
}

###############################################################################
###############################################################################

backup1 seagate tree.txt        "$@"
backup1 seagate activities/     "$@"
backup1 seagate directories/    "$@"
backup1 seagate downloads/      "$@"
backup1 seagate encrypted/      "$@"
backup1 seagate git/            "$@"
backup1 seagate library/        "$@"
backup1 seagate media/          "$@"
backup1 seagate vm/             "$@"


backup1 hitachi tree.txt        "$@"
backup1 hitachi activities/     "$@"
# backup1 hitachi directories/    "$@"
backup1 hitachi downloads/      "$@"
backup1 hitachi encrypted/      "$@"
backup1 hitachi git/            "$@"
backup1 hitachi library/        "$@"
backup1 hitachi media/          "$@"
# backup1 hitachi vm/             "$@"


backup1 wdc     tree.txt        "$@"
backup1 wdc     activities/     "$@"
# backup1 wdc     directories/    "$@"
backup1 wdc     downloads/      "$@"
backup1 wdc     encrypted/      "$@"
backup1 wdc     git/            "$@"
backup1 wdc     library/        "$@"
backup1 wdc     media/          "$@"
# backup1 wdc     vm/             "$@"

