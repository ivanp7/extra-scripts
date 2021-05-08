#!/bin/sh

DREAM_JOURNAL_DIRECTORY=$HOME/data/files/text/dream_journal

[ ! -d "$DREAM_JOURNAL_DIRECTORY" ] && {
    echo "Dream journal directory doesn't exist!"
    exit 1
}

ENTRY_NAME="$(date +'%Y-%m-%d_%a.txt')"
nvim "$DREAM_JOURNAL_DIRECTORY/$ENTRY_NAME"

