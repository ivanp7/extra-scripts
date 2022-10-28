#!/bin/sh

OPTIONS="$@"

backup ()
{
    local category="$1"
    local host="$2"
    local disk="$3"
    shift 3

    echo
    echo "===================================================================="
    echo "Backing up '$category' to disk '$disk' of host '$host'."
    echo "--------------------------------------------------------------------"
    echo

    remote -h "$host" -wo upload -l "$HOME/data/$category/" -r "/mnt/$disk/data/$category/" "$@" $OPTIONS --rsync-opts -arz
}

###############################################################################

BACKUP_HOST_1="home-1"
BACKUP_HOST_2="home-2"

backup_seagate ()
{
    local category="$1"
    shift 1
    backup "$category" "$BACKUP_HOST_1" seagate "$@"
}

backup_hitachi ()
{
    local category="$1"
    shift 1
    backup "$category" "$BACKUP_HOST_1" hitachi "$@"
}


backup_wdc ()
{
    local category="$1"
    shift 1
    backup "$category" "$BACKUP_HOST_2" wdc "$@"
}

###############################################################################
###############################################################################

backup_seagate activities
backup_seagate archive
backup_seagate encrypted-directories
backup_seagate files
backup_seagate git
backup_seagate library
backup_seagate media

backup_seagate directories
backup_seagate downloads
backup_seagate vm
backup_seagate Windows

backup_hitachi activities
backup_hitachi archive
backup_hitachi encrypted-directories
backup_hitachi files
backup_hitachi git
backup_hitachi library
backup_hitachi media

backup_wdc     activities
backup_wdc     archive
backup_wdc     encrypted-directories
backup_wdc     files
backup_wdc     git
backup_wdc     library
backup_wdc     media

