#!/bin/bash

echo "copy config"
sudo cp etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
sudo cp etc/network/interfaces /etc/network/interfaces
sudo cp etc/rc.local /etc/rc.local

echo "Reboot to update config"

