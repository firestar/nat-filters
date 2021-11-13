#!/bin/bash
#
##
Network=192.168.122.0/24
##
#
iptables -t raw -A PREROUTING --destination $Network -j TRACE
#iptables -t raw -A OUTPUT --destination $Network -j TRACE
