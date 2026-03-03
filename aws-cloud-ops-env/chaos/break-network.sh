#!/usr/bin/env bash
# break-network.sh — Simulate a network outage for chaos testing

set -e

echo "[*] Dropping all inbound and outbound network traffic..."
sudo iptables -A INPUT -j DROP
sudo iptables -A OUTPUT -j DROP

echo "[*] Network is now blocked."
echo "[*] Restore with: sudo iptables -F"

