#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# add release version to /etc/os-release
VERSION=$(git --git-dir=../.git --work-tree=../ describe --dirty --always --tags)
echo "Building version: ${VERSION}"
echo "SYSTEM=${VERSION}" >> "$TARGET_DIR/etc/os-release" 2> /dev/null
(d="$(git --git-dir=../.git log --date=iso --pretty=%ad -1)"; echo "$d") > $TARGET_DIR/etc/os-release
