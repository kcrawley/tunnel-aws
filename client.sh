#!/bin/sh

cd /etc/openvpn/
cat > ${INSTANCE}.conf <<OPENVPN
dev tun
dhcp-option DNS 8.8.8.8
ifconfig 10.10.10.2 10.10.10.1
port 443
proto tcp-client
redirect-gateway def1
remote ${INSTANCE}
secret ${INSTANCE}.key
OPENVPN
apt-get install -y zip
zip client.zip ${INSTANCE}.conf ${INSTANCE}.key
