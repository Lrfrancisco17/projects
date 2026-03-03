#!/usr/bin/env bash
# fill-disk.sh — Fill disk space to simulate low-storage conditions

set -e

SIZE="${1:-1G}"
FILE="/tmp/disk_fill_test"

echo "[*] Filling disk with $SIZE..."
dd if=/dev/zero of="$FILE" bs=1M count=$(( ${SIZE%G} * 1024 )) status=progress

echo "[*] Disk fill complete. Remove with: rm -f $FILE"

