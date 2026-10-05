#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo:"
    echo "sudo ./setup.sh"
    exit 1
fi

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_DIR"

echo "=================================="
echo " TaskFlow SIS #2 Setup"
echo " Users and Permissions"
echo "=================================="

echo
echo "[1/5] Creating users and groups..."
./scripts/01_users_groups.sh

echo
echo "[2/5] Configuring permissions..."
./scripts/02_permissions.sh

echo
echo "[3/5] Configuring sudoers..."
./scripts/03_sudoers.sh

echo
echo "[4/5] Configuring SSH..."
./scripts/04_ssh_setup.sh

echo
echo "[5/5] Installing systemd service..."
./scripts/05_systemd_setup.sh

echo
echo "=================================="
echo " Setup completed successfully!"
echo "=================================="

systemctl is-enabled taskflow
systemctl is-active taskflow
