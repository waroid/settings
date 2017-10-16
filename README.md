
1. start config
	-[A] sudo raspi-config
		Hostname -> DEV-0 or DEV-2 or DEV-DRIVER
		Boot Options -> Desktop / CLI -> Console Autologin
		Localisation Options -> Change Timezone -> Asia -> Seoul
		Localisation Options -> Change Keyboard Layout -> Generic 105-key (Intl) PC -> Other -> Korean -> Korean - Korean (101/104 key compatible) - The default for the keyboard layout -> No compose key
		Interfacing Options -> Camera -> Yes
		Interfacing Options -> SSH -> Yes
		Advanced Options -> Expand Filesystem
		Advanced Options -> Audio -> Force 3.5mm
	
2. internet setting
	-[0] sudo vi /etc/network/interfaces
		allow-hotplug wlan0
		iface wlan0 inet dhcp
		wpa-ssid waroid-2.4g
		wpa-psk 12345678
		
	-[0] sudo reboot
	
3. update and upgrade
	-[A] sudo apt-get update
	-[A] sudo apt-get upgrade
	-[A] sudo apt-get install git wiringpi
	-[A] mkdir Work && cd Work
	-[A] git clone https://github.com/waroid/settings.git

4. update config
	-[0] cd Work/settings/0
	-[2] cd Work/settings/2
	-[A] sudo cp etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
	-[A] sudo cp etc/network/interfaces /etc/network/interfaces
	-[A] sudo cp etc/rc.local /etc/rc.local
	-[0] sudo cp boot/config.txt /boot/config.txt
	-[A] sudo reboot
	
5. test
	-[A] ifconfig -a
	-[A] iwconfig
	-[A] raspistill -o 1.jpg
	-[A] raspivid -o 1.h264
	-[A] rm 1.*
	-[A] gpio -v
	-[A] gpio readall
	
# dhcpcd 충돌
	-[A] dpkg -l | grep dhcp
	-[A] sudo apt-get remove dhcpcd5
	
# set NEXT 510AC mini driver
	-[A] cd Work/settings/driver
	-[0] tar xzf 8812au-4.9.41-1023.tar.gz (download: wget http://www.fars-robotics.net/8812au-4.9.41-1023.tar.gz)
	-[2] tar xzf 8812au-4.9.41-v7-1023.tar.gz (download: wget http://www.fars-robotics.net/8812au-4.9.41-v7-1023.tar.gz)
	-[A] ./install.sh
	-[A] sudo reboot
	
# set EDIMAX EW 7822ULC
	-[A] cd Work/settings/driver
	-[0] tar xzf 8822bu-4.9.41-1023.tar.gz (kernel compile)
	-[A] ./install.sh
	
#set bluetooth
	-[0] cd Work/settings/0
	-[0] sudo cp etc/systemd/system/bluetooth.target.wants/bluetooth.service /etc/systemd/system/bluetooth.target.wants/bluetooth.service
	-[0] sudo cp etc/systemd/system/rfcomm.service /etc/systemd/system/rfcomm.service
	-[0] sudo reboot
	
	-[0] sudo bluetoothctl
		agent on
		default-agent
		discoverable on
		scan on
		pair C0:33:5E:34:7D:FA
		trust C0:33:5E:34:7D:FA
	
#camera test
	-[A] cd Work
	-[A] git clone https://github.com/waroid/CameraTestServer.git
	-[A] cd CameraTestServer
	-[A] make
	-[A] sudo make install
	-[A] sudo vi /etc/rc.local
		=> using camera test server
	-[A] sudo vi /etc/network/interfaces
		=> disable control(wlan0)
		
# newwaroid install
	-[A] cd Work
	-[A] git clone https://github.com/waroid/NewWaroid.git
	-[A] cd NewWaroid
	-[A] make
	-[A] sudo make install
	-[A] sudo vi /etc/rc.local
		=> using new waroid server
	-[A] sudo vi /etc/network/interfaces
		=> disable control(wlan0)
