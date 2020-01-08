# MyScripts
Some Bash Scripts that I created. - I will add as I go - 

After downloading run commands:
 1. dos2unix Maven_Debian_setup.sh
 2. chmod +x ./Maven_Debian_setup.sh
 3. ./Maven_Debian_setup.sh
 
Maven_Debian_setup.sh = make sure to look for 'mike' and change to your username. at the end of the script it will end within another script "totalrecon", after dependencies are installed select option 88 to install all programs to complete the setup. Its not a pretty script but it completes its purpose. This script does autoclean and is only intended for after a fresh installation of Debian buster.

After script runs add virtualbox.list to /etc/apt/sources.list.d 
                      "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian buster contrib"

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
-Totalrecon = downloads changes to directory gives scripts execution writes the calls it and enters 0 for the dependants
