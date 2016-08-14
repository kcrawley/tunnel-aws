#!/bin/sh

apt-get update && apt-get install -y openvpn
cd /etc/openvpn/
INSTANCE=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
openvpn --genkey --secret ${INSTANCE}.key
cat > openvpn.conf <<OPENVPN
dev tun1
ifconfig 10.10.10.1 10.10.10.2
port 443
proto tcp-server
secret ${INSTANCE}.key
OPENVPN
service openvpn restart
