#!/bin/bash
set -e

cd ~/taskflow-sis2

IP=$(hostname -I | awk '{print $1}')

echo "Ubuntu IP: $IP"

ip -br addr
ip route
ss -lnt

cat > sis3/network.dot <<DOT
digraph network {
    rankdir=LR;
    node [shape=box, style=rounded];

    Windows [label="Windows 11"];
    Ubuntu [label="Ubuntu WSL\nIP: $IP"];
    SSH [label="SSH Server\nTCP 22"];
    TaskFlow [label="TaskFlow\nTCP 8080"];
    GitHub [label="GitHub\nHTTPS 443"];

    Windows -> Ubuntu;
    Ubuntu -> SSH;
    Ubuntu -> TaskFlow;
    Ubuntu -> GitHub;
}
DOT

dot -Tpng sis3/network.dot -o sis3/network.png

echo "NETWORK DIAGRAM CREATED"
