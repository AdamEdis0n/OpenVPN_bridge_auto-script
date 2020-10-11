#!/bin/bash
# Author: Adam Edison
# Bridge
br="br0"
# TAP
tap="tap0"
# INTERFACES TO TAP
firstId=21; declare -A subInterface21=(
        [id]='21'
        [interface]='eth1.21'
        [ip]='192.168.21.1'
        [netmask]='255.255.255.224'
        [broadcast]='192.168.21.31' ) 
declare -A subInterface22=(
        [id]='22'
        [interface]='eth1.22'
        [ip]='192.168.22.1'
        [netmask]='255.255.255.224'
        [broadcast]='192.168.22.31' ) 
declare -A subInterface23=(
        [id]='23'
        [interface]='eth1.23'
        [ip]='192.168.23.1'
        [netmask]='255.255.255.224'
        [broadcast]='192.168.23.31' ) 
declare -A subInterface25=(
        [id]='25'
        [interface]='eth1.25'
        [ip]='192.168.25.1'
        [netmask]='255.255.255.224'
        [broadcast]='192.168.25.31' )

for t in $tap; do
    openvpn --mktun --dev $t 
done 

brctl addbr $br 

declare -n preSubInterface 
for preSubInterface in ${!subInterface@}; do
        echo "Interface: ${preSubInterface[interface]}"
        brctl addif $br ${preSubInterface[interface]} 
done 

for t in $tap; do
    brctl addif $br $t
    ifconfig $t 0.0.0.0 promisc up 
done 

declare -n preSubInterfaceIp 
for preSubInterfaceIp in ${!subInterface@}; do
        echo "Promisc up: ${preSubInterfaceIp[interface]}"
        ifconfig ${preSubInterfaceIp[interface]} 0.0.0.0 promisc up 
done 

declare -n subInterfaceBrs 
for subInterfaceBrs in ${!subInterface@}; do
        echo "$br:${subInterfaceBrs[id]}"

        if [ ${subInterfaceBrs[id]} == $firstId ]
        then
                ifconfig $br ${subInterfaceBrs[ip]} netmask ${subInterfaceBrs[netmask]} broadcast ${subInterfaceBrs[broadcast]}
        else
                ifconfig $br:${subInterfaceBrs[id]} ${subInterfaceBrs[ip]} netmask ${subInterfaceBrs[netmask]} broadcast ${subInterfaceBrs[broad$
        fi done
