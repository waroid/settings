
1. dhcpcd5 제거
	- sudo apt-get remove dhcpcd5
	
2. wifi 세팅
	- sudo vi /etc/network/interfaces
		allow-hotplug wlan0
		iface wlan0 inet dhcp
		wpa_ssid waroid-2.4g
		wpa-psk 12345678
		
	- sudo reboot
	
3. update and upgrade
	- sudo apt-get update
	- sudo apt-get upgrade
	- sudo apt-get install git
	- mkdir Work && cd Work
	- git clone https://github.com/waroid/settings.git
	
4. update config
	- cd Work/settings/0
	- sudo cp etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
	- sudo cp etc/network/interfaces /etc/network/interfaces
	- sudo cp etc/rc.local /etc/rc.local
	- sudo reboot
	
5. wifi driver(NEXT 510AC mini)
	- cd Work
	- wget http://www.fars-robotics.net/8812au-4.9.41-1023.tar.gz
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