#!/bin/bash

set -e

echo "=== Installing OpenSSH server ==="

apt update
apt install -y openssh-server

echo "=== Enabling SSH service ==="

systemctl enable --now ssh

echo "=== Preparing automation_bot SSH directory ==="

install -d -m 700 \
    -o automation_bot \
    -g automation_bot \
    /home/automation_bot/.ssh

if [ -f /home/kbtu/.ssh/taskflow_automation.pub ]; then

    install -m 600 \
        -o automation_bot \
        -g automation_bot \
        /home/kbtu/.ssh/taskflow_automation.pub \
        /home/automation_bot/.ssh/authorized_keys

    echo "Public key installed successfully."

else

    echo "ERROR: Public key not found."
    echo "Expected: /home/kbtu/.ssh/taskflow_automation.pub"
    exit 1

fi

echo "=== SSH configuration completed ==="
