#!/bin/sh

DATABASE_FILE="ivanp7.db.tar.xz"

if ! mountpoint -q "$HOME/mnt"
then
    if ! remote.py -Lh raspberry -o mount -l "$HOME/mnt" -r /srv/ftp/repos/main/x86_64
    then
        echo "Could not mount the repository directory"
        exit 1
    else
        # trap 'fusermount3 -u "$HOME/mnt"' EXIT
        : # no operation
    fi
fi

if [ ! -f "$HOME/mnt/$DATABASE_FILE" ]
then
    echo "$HOME/mnt is not a package repository"
    exit 1
fi

for pkg in "$@"
do
    BASENAME="$(basename -- "$pkg")"
    PKG_NAME="$(echo "$BASENAME" | sed 's/\(.*\)-[^-]\+-[^-]\+-[^-]\+\.pkg\.tar\.zst$/\1/')"

    # remove old signature
    find "$HOME/mnt" -type f -regextype sed -regex ".*/${PKG_NAME}-[^/-]\+-[^/-]\+-[^/-]\+\.pkg\.tar\.zst\.sig" -exec rm -- "{}" \;
    # copy new package
    install -m 644 -t "$HOME/mnt" -- "$pkg"
    # replace the package in the database
    repo-add -s -R "$HOME/mnt/$DATABASE_FILE" "$HOME/mnt/$BASENAME"
    # sign new package
    gpg --detach-sign --use-agent -- "$HOME/mnt/$BASENAME"
done

