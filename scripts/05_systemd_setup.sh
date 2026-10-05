#!/bin/bash

set -e

echo "=== Installing TaskFlow application ==="

cp service/app.py /opt/taskflow/app.py

chown taskflow:taskflow-dev /opt/taskflow/app.py
chmod 750 /opt/taskflow/app.py


echo "=== Installing systemd unit ==="

cp systemd/taskflow.service /etc/systemd/system/taskflow.service

chmod 644 /etc/systemd/system/taskflow.service


echo "=== Reloading systemd ==="

systemctl daemon-reload


echo "=== Enabling and starting TaskFlow ==="

systemctl enable --now taskflow


echo "=== Checking TaskFlow service ==="

systemctl is-enabled taskflow
systemctl is-active taskflow

echo "=== TaskFlow systemd service successfully configured ==="
