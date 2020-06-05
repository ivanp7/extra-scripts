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

    remote.ros -h "$host" -wo upload -l "$HOME/data/$category/" -r "/mnt/$disk/data/$category/" "$@" $OPTIONS --rsync-opts -arz
}

###############################################################################

PRIMARY_HOST="home-1"

backup_primary_wdc ()
{
    local category="$1"
    shift 1
    backup "$category" "$PRIMARY_HOST" wdc "$@"
}

backup_primary_hitachi ()
{
    local category="$1"
    shift 1
    backup "$category" "$PRIMARY_HOST" hitachi "$@"
}

###############################################################################

SECONDARY_HOST="home-2"

backup_secondary_samsung ()
{
    local category="$1"
    shift 1
    backup "$category" "$SECONDARY_HOST" samsung "$@"
}

backup_primary_seagate ()
{
    local category="$1"
    shift 1
    backup "$category" "$SECONDARY_HOST" seagate "$@"
}

###############################################################################
###############################################################################

backup_primary_wdc     activities
backup_primary_wdc     archive
backup_primary_wdc     encrypted-directories
backup_primary_wdc     files
backup_primary_wdc     git
backup_primary_wdc     library

backup_primary_hitachi vm

backup_secondary_samsung activities
backup_secondary_samsung files
backup_secondary_samsung git
backup_secondary_samsung library

backup_primary_seagate activities
backup_primary_seagate archive
backup_primary_seagate downloads
backup_primary_seagate encrypted-directories
backup_primary_seagate files
backup_primary_seagate git
backup_primary_seagate library
backup_primary_seagate media
backup_primary_seagate Windows

