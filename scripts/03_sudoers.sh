#!/bin/bash

set -e

echo "=== Creating TaskFlow sudoers configuration ==="

cat > /etc/sudoers.d/taskflow <<'EOF'
%taskflow-dev ALL=(root) /usr/bin/systemctl restart taskflow, /usr/bin/systemctl status taskflow

%taskflow-audit ALL=(root) /usr/bin/journalctl -u taskflow, /usr/bin/systemctl status taskflow

automation_bot ALL=(root) NOPASSWD: /usr/bin/systemctl restart taskflow, /usr/bin/systemctl status taskflow, /usr/bin/systemctl status taskflow --no-pager
EOF

chmod 440 /etc/sudoers.d/taskflow

echo "=== Checking sudoers syntax ==="

visudo -cf /etc/sudoers.d/taskflow

echo "=== Sudoers configuration successfully installed ==="
