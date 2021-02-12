#!/bin/bash

logo(){
  #against the law to have a batch script without a cool logo :D
  echo "${red}
      ||\\  //||   //\\  \\    // ||''' ||\\  || 
      || \\// ||  //==\\  \\  //  ||==  || \\ ||
      ||     || //    \\  \\//   ||,,, ||  \\||             
${reset}                                     "
}
########################################################################
# Date: 02/10/2021
# Combined several scripts to update outdated apps and add some custom
# firmaware and dependancies for my laptop
########################################################################

logo

export DEBIAN_FRONTEND=noninteractive;
echo "[****] Maven Initial Setup [****]"
echo "[****] Upgrade Installed Packages to Latest [****]"

#####Cut here if you dont want to autoclean##########
apt-get -qq update && apt-get -qq dist-upgrade -y
apt full-upgrade -y
apt-get autoclean
#####################################################

echo -e "\nInstalling default packages and dependancies...\n"
apt-get -y install aptitude
apt-get -y install wireless-tools
apt-get -y install network-manager-gnome
apt-get -y install transmission-cli
apt-get install -y libcurl4-openssl-dev
apt-get install -y libssl-dev
apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
apt-get install -y build-essential libssl-dev libffi-dev python-dev
apt-get install -y python-setuptools
apt-get install -y libldns-dev
apt-get install -y python3-pip
apt-get install -y python-pip
apt-get install -y python-dnspython
apt-get install -y rename
apt-get install -y git

##Antivirus#################
echo "[*] Install ClamAV [*]"
apt-get install clamav -y 
echo "[*] Finished installing ClamAV [*]"
#############################


apt-get install sudo -y

####Custom to me or my Laptop########
usermod -aG sudo  maven
apt-get -y install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,')
apt-get -y install firmware-linux-nonfree
apt install firmware-linux-nonfree intel-microcode -y
apt install firmware-linux firmware-linux-nonfree libdrm-amdgpu1 xserver-xorg-video-amdgpu -y
apt-get -y install gdebi firmware-linux
apt-get -y install broadcom-sta-dkms 
apt-get -y install firmware-iwlwifi
modprobe -r iwlwifi ; modprobe iwlwifi

echo "[++++] Install IP Vanish [++++]"
cd Downloads/
wget https://www.ipvanish.com/software/configs/configs.zip
cd ..
echo "[+++] go set up the VPN network manager and disable IPV6 [++++] "

echo "[+++] Set up firewall [++++]"
apt-get -y install ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

#####################################

echo " [-------------------] Common Programs[-------------------]"

echo "[*] keepnote [*]"
apt-get -y install keepnote

echo "[+++] install FlameShot [++++]"
apt install flameshot -y

###############Cut for Kali machine as well##############

echo "[*] Gedit [*]"
apt-get -y install gedit

echo "[*] Gedit [*]"
apt-get -y install dnsutils

echo "[*] tmux [*]"
apt-get -y install tmux

echo "[*] visualcode [*]"
apt install -y software-properties-common apt-transport-https curl
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
apt update
apt install code
#############################################################
echo "[====] Install Burp Suite [====]"
cd ~
wget https://portswigger.net/burp/releases/download?product=community&version=2.1.07&type=linux&componentid=100

echo "[*] Installing Nmap [*] "
apt-get install -y nmap
echo "[*] Finished installing Nmap [*] "

echo "[*] Installing WireShark [*] "
apt-get install -y wireshark
echo "[*] Finished installing WireShark [*] "

echo "[+] Installing and starting OWASP ZAP [+]"
wget https://github.com/zaproxy/zaproxy/releases/download/w2020-01-27/ZAP_WEEKLY_D-2020-01-27.zip
unzip ZAP_WEEKLY_D-2020-01-27.zip
echo "[+] Finished installing OWASP ZAP [+]"

    
echo "[*]Finished Installing All Apps - review and fix any errors during download[*]"
