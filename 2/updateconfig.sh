#!/bin/bash

echo "copy wpa_supplicant.conf"
sudo cp etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
echo "copy interfaces"
sudo cp etc/network/interfaces /etc/network/interfaces
echo "copy rc.local"
sudo cp etc/rc.local /etc/rc.local

echo "Reboot to update config"

