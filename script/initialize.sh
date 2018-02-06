#!/bin/bash

if [ "$EUID" -ne 0 ]
then 
	echo "Must be root"
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
systemctl disable dnsmasq

echo "All donw! please reboot"
