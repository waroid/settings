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

apt-get install wiringpi libasound2 libasound2-dev libsndfile1 libsndfile1-dev libttspico-utils syslog-ng hostapd dnsmasq -y

cp ../0/boot/config.txt /boot/config.txt
cp ../0/etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
cp ../0/etc/default/hostapd /etc/default/hostapd
cp ../0/etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf
cp ../0/etc/network/interfaces /etc/network/interfaces
cp ../0/etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
cp ../0/etc/dnsmasq.conf /etc/dnsmasq.conf
cp ../0/etc/rc.local /etc/rc.local

touch /var/log/waroid.log

systemctl disable dhcpcd
systemctl disable bluetooth
systemctl disable hostapd

if [ "$_WIFI_MODE" = "station" ]
then
	cat >> /etc/network/interfaces << EOF
allow-hotplug wlan1
iface wlan1 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface robot inet dhcp
EOF
	
	systemctl disable dnsmasq
else
	cat >> /etc/network/interfaces << EOF
allow-hotplug wlan1
iface wlan1 inet static
address 10.1.1.1
netmask 255.255.255.0
network 10.1.1.0
broadcast 10.1.1.255
hostapd /etc/hostapd/hostapd.conf
EOF
	
	systemctl enable dnsmasq
fi

echo "All donw! please reboot"
