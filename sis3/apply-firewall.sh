#!/bin/bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

sudo nft -c -f "$DIR/firewall.nft"

sudo tee /etc/systemd/system/sis3-firewall.service > /dev/null <<SERVICE
[Unit]
Description=SIS3 TaskFlow Firewall
After=nftables.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStartPre=-/usr/sbin/nft delete table inet sis3
ExecStart=/usr/sbin/nft -f $DIR/firewall.nft
ExecStop=-/usr/sbin/nft delete table inet sis3

[Install]
WantedBy=multi-user.target
SERVICE

sudo systemctl daemon-reload
sudo systemctl enable sis3-firewall
sudo systemctl restart sis3-firewall

sudo nft list table inet sis3
