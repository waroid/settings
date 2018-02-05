#!/bin/bash

if [ "$EUID" -ne 0 ]
then 
	echo "Must be root"
	exit
fi

if [[ $# -lt 1 ]]
then
	echo "You need to pass a wifi mode!"
	echo "Usage:"
	echo "sudo $0 <station|ap>"
	exit
fi

_WIFI_MODE="$1"
if [ "$_WIFI_MODE" != "station" -a "$_WIFI_MODE" != "ap" ]
then
	echo "$_WIFI_MODE is unknown."
	echo "Usage:"
	echo "sudo $0 <station|ap>"
	exit
fi

apt-get update -yqq
apt-get upgrade -yqq
	
cp ../0/boot/config /boot/config
cp ../0/etc/network/interfaces /etc/network/interfaces
cp ../0/etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
cp ../0/etc/dhcpcd.conf.origin /etc/dhcpcd.conf
cp ../0/etc/rc.local /etc/rc.local

if [ "$_WIFI_MODE" = "station" ]
then
	cat >> /etc/network/interfaces 
	allow-hotplug wlan1
	iface wlan1 inet manual
	wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
	iface robot inet dhcp
	EOF
	
	sysctl -w net.ipv4.ip_forward=0
	
	sed -i -- 's/_GAME_SERVER_IP="none"/_GAME_SERVER_IP="192.168.1.201"/g' /etc/rc.local
else
	apt-get install hostapd dnsmasq -yqq
	
	cp ../0/etc/default/hostapd /etc/default/hostapd
	cp ../0/etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf
	cp ../0/etc/network/iptables.ipv4.nat /etc/network/iptables.ipv4.nat
	cp ../0/etc/dnsmasq.conf /etc/dnsmasq.conf
	
	cat >> /etc/network/interfaces 
	allow-hotplug wlan1
	iface wlan1 inet static
	address 10.1.1.1
	netmask 255.255.255.1
	#up itables-restore < /etc/network/iptables.ipv4.nat
	EOF
	
	echo "denyinterfaces wlan1" >> /etc/dhcpcd.conf
	
	sysctl -w net.ipv4.ip_forward=1
	
	systemctl enable hostapd
	systemctl enable dnsmasq
	
	service hostapd start
	service dnsmasq start
fi

echo "All donw! please reboot"