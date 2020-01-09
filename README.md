# MyScripts and a few .txt files
Some Bash Scripts that I created. - I will add as I go and learn - 

After downloading run commands:
*********************************
chmod +x ./Maven_Debian_setup.sh
*********************************
  ./Maven_Debian_setup.sh
*********************************  
 
Maven_Debian_setup.sh - Designed to be ran after installing Debian 'Buster' for the first time. script is catogorized to be modified to fit individual needs easily. Still a work in progress as I add more and clean it up. Adding and updating more programs and dependencies to complete the setup. 

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
-rar 
-transmission-cli = which is used to dowload and install the Kali VM torrent to downloads folder
-FlameShot
-IP Vanish = network manager still has to be set up and IPV6 needs to be disabled to ensure no DNS leakage
-GOLang = and configures it under home/mike/go
-Burp Suite
-Gedit
-VirtualBox
-Kali virtualbox image
-chrome
-lazyrecon script = it runs dos2unix to convert if needed then gives it execute writes
-NMAP
-HTTPROBE
-Amass
-Meg
-Inscope
-LinkFinder
-fuff

