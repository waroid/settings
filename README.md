
1. start config
	-[A] sudo raspi-config
		Hostname -> DEV or DEV-2
		Boot Options -> Desktop / CLI -> Console Autologin
		Localisation Options -> Change Timezone -> Asia -> Seoul
		Localisation Options -> Change Keyboard Layout -> Generic 105-key (Intl) PC -> Other -> Korean -> Korean - Korean (101/104 key compatible) - The default for the keyboard layout -> No compose key
		Interfacing Options -> Camera -> Yes
		Interfacing Options -> SSH -> Yes
		Advanced Options -> Expand Filesystem
	
2. internet setting
	-[0] sudo vi /etc/network/interfaces
		allow-hotplug wlan0
		iface wlan0 inet dhcp
		wpa_ssid waroid-2.4g
		wpa-psk 12345678
		
	-[A] sudo reboot
	
3. update and upgrade
	-[A] sudo apt-get update
	-[A] sudo apt-get upgrade
	-[A] sudo apt-get install git
	-[A] mkdir Work && cd Work
	-[A] git clone https://github.com/waroid/settings.git
	
4. update config
	- cd Work/settings/0
	- sudo cp etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
	- sudo cp etc/network/interfaces /etc/network/interfaces
	- sudo cp etc/rc.local /etc/rc.local
	- sudo reboot

* dhcpcd 충돌
	-[0] sudo apt-get remove dhcpcd5
	

* set NEXT 510AC mini driver
	- cd Work
	- wget http://www.fars-robotics.net/8812au-4.9.41-1023.tar.gz [0]
	- wget http://www.fars-robotics.net/8812au-4.9.41-v7-1023.tar.gz [2]
	- tar xzf 8812au-4.9.41-1023.tar.gz
	- ./install.sh
	
#set bluetooth
	- cd Work/settings/0
	- sudo cp etc/systemd/system/bluetooth.target.wants/bluetooth.service /etc/systemd/system/bluetooth.target.wants/bluetooth.service
	- sudo cp etc/systemd/system/rfcomm.service /etc/systemd/system/rfcomm.service
	- sudo reboot
	
	- sudo bluetoothctl
	- agent on
	- default-agent
	- discoverable on
	- scan on
	- pair C0:33:5E:34:7D:FA
	- trust C0:33:5E:34:7D:FA
	
#camera test
	- cd Work
	- git clone https://github.com/waroid/CameraTestServer.git
	- cd CameraTestServer
	- make
	- sudo make install
	- sudo vi /etc/rc.local
		=> using camera test server
	- sudo vi /etc/network/interfaces
		=> disable control(wlan0)