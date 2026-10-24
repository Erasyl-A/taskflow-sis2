#!/bin/bash
set -e

cd ~/taskflow-sis2

echo "===== SIS 3 SMOKE TEST ====="

echo "[1] Graphviz"
dot -V
echo "PASS: Graphviz"

echo "[2] GitHub CLI"
gh --version | head -n 1
echo "PASS: GitHub CLI"

echo "[3] Python Requests"
sis3/.venv/bin/python -c "import requests; print(requests.__version__)"
echo "PASS: Requests"

echo "[4] SSH"
systemctl is-active --quiet ssh
echo "PASS: SSH"

echo "[5] TaskFlow"
systemctl is-active --quiet taskflow
echo "PASS: TaskFlow"

echo "[6] HTTP"
curl -sS -o /dev/null http://127.0.0.1:8080/
echo "PASS: HTTP connection"

echo "[7] Firewall"
sudo nft list table inet sis3
echo "PASS: Firewall table exists"

echo "=============================="
echo "ALL SMOKE TESTS PASSED"
echo "=============================="
