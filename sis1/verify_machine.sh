#!/usr/bin/env bash
set -euo pipefail
# SIS 1 read-only evidence collection; safe for an existing TaskFlow setup.
BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$BASE/evidence"
LOG="$BASE/evidence/machine-check.txt"
{
  echo "=== SIS 1 MACHINE VERIFICATION ==="
  date -Is
  echo "=== USER / MACHINE ==="
  whoami; hostname; uname -a
  echo "=== OS ==="
  cat /etc/os-release
  echo "=== VIRTUALIZATION ==="
  systemd-detect-virt || true
  echo "=== HOST / PROCESSOR / MEMORY ==="
  nproc; free -h; df -h /
  echo "=== IP ADDRESSES ==="
  ip -br addr
  echo "=== ROUTES ==="
  ip route
  echo "=== LISTENING PORTS ==="
  ss -lnt
  echo "=== SYSTEMD SERVICES ==="
  for service in taskflow ssh nginx; do
    printf "%s: " "$service"
    systemctl is-active "$service" 2>/dev/null || true
  done
  echo "=== TASKFLOW HTTP ==="
  curl -sS -o /dev/null -w 'HTTP response: %{http_code}\n' \
    --connect-timeout 2 --max-time 5 http://127.0.0.1:8080/ || true
  echo "=== FILESYSTEM DIRECTORIES ==="
  for path in /opt/taskflow /etc/taskflow /var/log/taskflow /srv/taskflow/backups; do
    if [ -e "$path" ]; then ls -ld "$path"; else echo "NOT PRESENT: $path"; fi
  done
  echo "=== GIT REPOSITORY ==="
  git -C "$HOME/taskflow-sis2" remote -v || true
  echo "=== END ==="
} 2>&1 | tee "$LOG"
printf 'Saved: %s\n' "$LOG"
