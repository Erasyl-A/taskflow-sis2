#!/bin/bash

set -e

echo "=== Creating TaskFlow directories ==="

mkdir -p /opt/taskflow
mkdir -p /etc/taskflow
mkdir -p /var/log/taskflow
mkdir -p /srv/taskflow/backups


echo "=== Configuring application permissions ==="

chown -R taskflow:taskflow-dev /opt/taskflow
chmod -R 775 /opt/taskflow


echo "=== Configuring configuration permissions ==="

chown -R root:taskflow /etc/taskflow
chmod -R 750 /etc/taskflow


echo "=== Configuring log permissions ==="

chown -R taskflow:taskflow-audit /var/log/taskflow
chmod -R 750 /var/log/taskflow


echo "=== Configuring backup permissions ==="

chown -R root:taskflow-admin /srv/taskflow/backups
chmod -R 750 /srv/taskflow/backups


echo "=== Permissions successfully configured ==="
