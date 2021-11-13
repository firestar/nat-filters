#!/bin/bash
echo "\t Setting up ip forwarding for 192.168.122.x"
modprobe iptable_nat
modprobe ip_conntrack
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s 192.168.122.0/24 -j MASQUERADE
iptables -A FORWARD -o virbr0 -i enp4s0 -s 192.168.122.0/24 -m conntrack --ctstate ESTABLISHED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT

sleep 25

iptables -D LIBVIRT_FWI -o virbr0 -j REJECT --reject-with icmp-port-unreachable
