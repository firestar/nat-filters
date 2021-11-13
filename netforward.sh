#!/bin/bash
#
##
InDev=enp4s0
OutDev=virbr0
Network=192.168.122.0/24
##
#

echo "\t Setting up ip forwarding for ${Network} from ${InDev} to ${OutDev}"

modprobe iptable_nat
modprobe ip_conntrack
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s $Network -j MASQUERADE
iptables -A FORWARD -o $OutDev -i $InDev -s $Network -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

sleep 25
# Remove rule automatically created to block this...
iptables -D LIBVIRT_FWI -o virbr0 -j REJECT --reject-with icmp-port-unreachable
