
1. start config
	-[A] sudo raspi-config
		Change User Password -> ????
		Network Options -> Hostname -> DEV-0W or BACKUP-0W or DEV-DRIVER
		Network Options -> Wi-fi -> waroid-2.4g -> 12345678 
		Boot Options -> Desktop / CLI -> Console Autologin
		Localisation Options -> Change Timezone -> Asia -> Seoul
		Localisation Options -> Change Keyboard Layout -> Generic 105-key (Intl) PC -> Other -> Korean -> Korean - Korean (101/104 key compatible) - The default for the keyboard layout -> No compose key
		Interfacing Options -> Camera -> Yes
		Interfacing Options -> SSH -> Yes
		Interfacing Options -> Serial -> No -> Yes
		Advanced Options -> Expand Filesystem
		Advanced Options -> Audio -> Force 3.5mm
	
2. update and upgrade
	-[A] sudo apt-get update
	-[A] sudo apt-get upgrade
	-[A] sudo apt-get install git
	-[A] mkdir Work && cd Work
	-[A] git clone https://github.com/waroid/settings.git
	-[A] cd settings/driver
	-[0] tar xvzf 8822bu-4.9.59-1047.tar.gz
	-[A] ./install.sh
	-[A] sudo reboot

3. update config
	-[A] cd Work/settings/script
	-[A] sudo ./intialize.sh
	-[A] sudo reboot
	-[A] sudo ./wifi.sh <station|ap>
	-[A] sudo reboot
	
4. test
	-[A] ifconfig -a
	-[A] iwconfig
	-[A] raspistill -o 1.jpg
	-[A] raspivid -o 1.h264
	-[A] rm 1.*
	-[A] gpio -v
	-[A] gpio readall
	
5 newwaroid install
	-[A] cd Work
	-[A] git clone https://github.com/waroid/NewWaroid.git
	-[A] cd NewWaroid
	-[A] make
	-[A] make install
	-[A] sudo vi /etc/rc.local
		=> using new waroid server
		=> set server ip
	
# syslog
	-[A] sudo apt-get install syslog-ng
	-[A] sudo touch /var/log/waroid.log
	-[0] cd Work/settings/0
	-[A] sudo cp etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
	-[A] sudo systemctl restart syslog-ng.service
	
# set NEXT 510AC mini driver
	-[A] cd Work/settings/driver
	-[0] tar xzf 8812au-4.9.41-1023.tar.gz (download: wget http://www.fars-robotics.net/8812au-4.9.41-1023.tar.gz)
	-[0] tar xzf 8812au-4.9.41-1023.tar.gz (download: wget http://www.fars-robotics.net/8812au-4.9.59-1047.tar.gz)
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
		
# python serial
	-[A] sudo apt-get install python-serial
	
# GStreamer
	-[A] sudo apt-get install gstreamer1.0-tools
	-[A] sudo apt-get install gstreamer1.0-bad
	-[A] sudo apt-get install gstreamer1.0-good
	
	