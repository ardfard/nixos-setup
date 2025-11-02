#!/usr/bin/env bash

# Script to set VNC password for running QEMU instance
# Usage: ./set-vnc-password.sh <password>

if [ $# -eq 0 ]; then
    echo "Usage: $0 <password>"
    echo "Example: $0 mypassword123"
    exit 1
fi

PASSWORD="$1"

# Connect to QEMU monitor and set VNC password
echo "change vnc password ${PASSWORD}" | socat - unix-connect:/tmp/qemu-monitor.sock

echo "VNC password set. You can now connect using this password."


