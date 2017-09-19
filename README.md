
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
	- mkdir Work & cd Work
	- git clone https://github.com/waroid/settings.git
	
3. wifi update
	- sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
	- sudo vi /etc/network/interfalces