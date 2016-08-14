#!/bin/sh

modprobe iptable_nat
echo 1 | tee /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s 10.10.10.1/2 -o eth0 -j MASQUERADE

INSTANCE=$(curl http://169.254.169.254/latest/meta-data/public-hostname)

apt-get update && apt-get install -y openvpn

cd /etc/openvpn/
openvpn --genkey --secret ${INSTANCE}.key

cat > openvpn.conf <<OPENVPN
dev tun1
ifconfig 10.10.10.1 10.10.10.2
port 443
proto tcp-server
secret ${INSTANCE}.key
OPENVPN

service openvpn restart
