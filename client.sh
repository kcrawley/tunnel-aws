#!/bin/sh

INSTANCE=$(curl http://169.254.169.254/latest/meta-data/public-hostname)

apt-get install -y zip

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

zip client.zip ${INSTANCE}.conf ${INSTANCE}.key
echo \#\# fetch the client.zip from the remote and extract configuration locally
echo \#\# scp -oStrictHostKeyChecking=no ubuntu@${INSTANCE}:/etc/openvpn/client.zip . \&\& unzip client.zip -d \~/Library/Application\\ Support/Tunnelblick/Configurations
