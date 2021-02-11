# MyScripts and a few .txt files
Some Bash Scripts that I created or found that were useful. - I will add as I go and learn - 

After downloading run commands as sudo:
*********************************
chmod +x NewDebianMaven.sh
*********************************
  ./NewDebianMaven.sh
*********************************  
***Use at your own risk*** 
NewDebianMaven.sh - Designed to be ran after installing Debian 'Buster' for the first time. Script is catogorized so it can be modified as needed to fit individual needs easier. Still a work in progress as I add more and clean it up. Adding and updating more programs and dependencies to complete the setup. 

******Warning***********************************************************************************
This script does autoclean and is only intended for after a fresh installation of Debian buster.
************************************************************************************************

This scripts installs the following:
-ufw = Firewall and configures it
-sudo = and adds my user to sudo
-linux headers
-firmware-linux-nonfree
-network-manager-gnome
-wireless tools
-firmware for intel-microcode
-broadcom-sta-dkms
-transmission-cli = which is used to dowload and install the Kali VM torrent to downloads folder
-FlameShot
-IP Vanish = network manager still has to be set up and IPV6 needs to be disabled to ensure no DNS leakage
-GOLang 
-Burp Suite
-Gedit
-VirtualBox
-Kali VMWare image


