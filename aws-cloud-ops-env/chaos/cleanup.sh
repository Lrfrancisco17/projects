#!/usr/bin/env bash
# cleanup.sh — Restore system state after chaos tests

echo "[*] Cleaning up chaos test artifacts..."

sudo iptables -F
rm -f /tmp/disk_fill_test

echo "[*] Cleanup complete."

