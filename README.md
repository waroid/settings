
1. dhcpcd5 제거
	- sudo apt-get remove dhcpcd5
	
2. wifi 세팅
	- sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
		network={
			ssid="waroid-2.4g"
			psk="12345678"
		}
	- sudo reboot
	
3. update and upgrade
	- sudo apt-get update
	- sudo apt-get upgrade
	- sudo apt-get install git
	- mkdir Work && cd Work
	- git clone https://github.com/waroid/settings.git
	
4. update config
	- cd settings/0
	- sudo cp etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
	- sudo cp etc/network/interfaces /etc/network/interfaces
	- sudo cp etc/rc.local /etc/rc.local
	
5. set bluetooth
	