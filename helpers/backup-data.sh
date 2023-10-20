#!/bin/sh

OPTIONS="$@"

backup_cmd ()
{
    local host="$1"
    local disk="$2"
    local object="$3"
    local rsync_opts="$4"
    shift 4

    echo
    echo "===================================================================="
    echo "Backing up '$object' to disk '$disk' of host '$host'."
    echo "--------------------------------------------------------------------"
    echo

    remote.py -h "$host" -u ivanp7 -wo upload -l "$HOME/data/$object" -r "/mnt/$disk/data/$object" "$@" $OPTIONS --rsync-opts="$rsync_opts"
}

if [ -s "$HOME/data/changes.txt" ]
then
    echo "Error: changes.txt is not empty, please update target directory tree and clear changes.txt"
    exit 1
fi

###############################################################################

backup1 ()
{
    local host="$1"
    local object="$2"

    backup_cmd "home-1" "$host" "$object" "-az"
}

###############################################################################
###############################################################################

backup1 seagate tree.txt
backup1 seagate activities
backup1 seagate directories
backup1 seagate downloads
backup1 seagate encrypted
backup1 seagate git
backup1 seagate library
backup1 seagate media
backup1 seagate vm


backup1 hitachi tree.txt
backup1 hitachi activities
# backup1 hitachi directories
# backup1 hitachi downloads
backup1 hitachi encrypted
backup1 hitachi git
backup1 hitachi library
backup1 hitachi media
# backup1 hitachi vm


backup1 wdc     tree.txt
backup1 wdc     activities
# backup1 wdc     directories
# backup1 wdc     downloads
backup1 wdc     encrypted
backup1 wdc     git
backup1 wdc     library
backup1 wdc     media
# backup1 wdc     vm

