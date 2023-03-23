#!/bin/sh

DATABASE_FILE="ivanp7.db.tar.xz"

: ${MOUNT_POINT:="$HOME/net"}

if ! mountpoint -q "$MOUNT_POINT"
then
    if ! remote.py -Lh raspberry -o mount -l "$MOUNT_POINT" -r /srv/ftp/repos/main/x86_64
    then
        echo "Could not mount the repository directory"
        exit 1
    else
        # trap 'fusermount3 -u "$MOUNT_POINT"' EXIT
        : # no operation
    fi
fi

if [ ! -f "$MOUNT_POINT/$DATABASE_FILE" ]
then
    echo "$MOUNT_POINT is not a package repository"
    exit 1
fi

for pkg in "$@"
do
    BASENAME="$(basename -- "$pkg")"
    PKG_NAME="$(echo "$BASENAME" | sed 's/\(.*\)-[^-]\+-[^-]\+-[^-]\+\.pkg\.tar\.zst$/\1/')"

    # remove old signature
    find "$MOUNT_POINT" -type f -regextype sed -regex ".*/${PKG_NAME}-[^/-]\+-[^/-]\+-[^/-]\+\.pkg\.tar\.zst\.sig" -exec rm -- "{}" \;
    # copy new package
    install -m 644 -t "$MOUNT_POINT" -- "$pkg"
    # replace the package in the database
    repo-add -s -R "$MOUNT_POINT/$DATABASE_FILE" "$MOUNT_POINT/$BASENAME"
    # sign new package
    gpg --detach-sign --use-agent -- "$MOUNT_POINT/$BASENAME"
done

