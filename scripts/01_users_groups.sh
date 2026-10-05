#!/bin/bash

set -e

echo "=== Creating TaskFlow groups ==="

groupadd -f taskflow-admin
groupadd -f taskflow-dev
groupadd -f taskflow-audit
groupadd -f taskflow-automation


echo "=== Creating human users ==="

if ! id administrator >/dev/null 2>&1; then
    useradd -m -s /bin/bash administrator
fi

if ! id developer >/dev/null 2>&1; then
    useradd -m -s /bin/bash developer
fi

if ! id auditor >/dev/null 2>&1; then
    useradd -m -s /bin/bash auditor
fi

if ! id automation_bot >/dev/null 2>&1; then
    useradd -m -s /bin/bash automation_bot
fi


echo "=== Assigning groups ==="

usermod -aG sudo,taskflow-admin administrator
usermod -aG taskflow-dev developer
usermod -aG taskflow-audit auditor
usermod -aG taskflow-automation,taskflow-dev automation_bot


echo "=== Creating TaskFlow service account ==="

if ! id taskflow >/dev/null 2>&1; then
    useradd --system \
        --user-group \
        --no-create-home \
        --shell /usr/sbin/nologin \
        taskflow
fi


echo "=== Users and groups successfully configured ==="
