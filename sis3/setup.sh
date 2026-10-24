#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$DIR/evidence"

exec > >(tee "$DIR/evidence/install.log") 2>&1

echo "===== SIS 3: PACKAGE INSTALLATION ====="

echo "===== 1. DEFAULT REPOSITORY ====="

sudo apt update

sudo apt install -y \
    graphviz \
    nftables \
    python3-venv \
    curl \
    ca-certificates \
    openssh-server

dot -V

echo "===== 2. NEW REPOSITORY ====="

sudo mkdir -p /etc/apt/keyrings

curl -fsSL \
    https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    -o /tmp/githubcli-archive-keyring.gpg

sudo install -m 0644 \
    /tmp/githubcli-archive-keyring.gpg \
    /etc/apt/keyrings/githubcli-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
sudo tee /etc/apt/sources.list.d/github-cli.list

sudo apt update
sudo apt install -y gh

gh --version
apt-cache policy gh

echo "===== 3. INSTALLATION WITHOUT APT ====="

python3 -m venv "$DIR/.venv"

"$DIR/.venv/bin/python" -m pip install requests

"$DIR/.venv/bin/python" -m pip show requests

echo "===== 4. START SERVICES ====="

sudo systemctl enable --now ssh
sudo systemctl start taskflow

echo "===== INSTALLATION COMPLETED ====="
