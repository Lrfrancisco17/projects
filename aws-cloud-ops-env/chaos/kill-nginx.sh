#!/usr/bin/env bash
# kill-nginx.sh — Kill the NGINX process to simulate a service crash

set -e

echo "[*] Attempting to kill NGINX..."
PID=$(pgrep -f nginx || true)

if [ -z "$PID" ]; then
  echo "[!] NGINX is not running."
  exit 1
fi

kill -9 "$PID"
echo "[*] NGINX has been terminated."

