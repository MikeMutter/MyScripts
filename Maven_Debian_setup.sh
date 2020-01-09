#!/bin/bash

export DEBIAN_FRONTEND=noninteractive;
echo "[****] Maven Initial Setup [****]"
echo "[****] Upgrade Installed Packages to Latest [****]"
apt-get -qq update && apt-get -qq dist-upgrade -y
apt full-upgrade -y
apt-get autoclean

echo -e "\nInstalling default packages...\n"
apt-get -y install aptitude
apt install sudo -y
usermod -aG sudo  mike
apt-get -y install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,')
apt-get -y install firmware-linux-nonfree
apt-get -y install wireless-tools
apt-get -y install network-manager-gnome
apt-get -y install gdebi gksu firmware-linux firmware-linux-nonfree intel-microcode
apt install firmware-linux firmware-linux-nonfree libdrm-amdgpu1 xserver-xorg-video-amdgpu -y
apt-get -y install broadcom-sta-dkms 
apt-get -y rar
apt-get -y install transmission-cli

echo "[+++] Set up firewall [++++]"
apt-get -y install ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable


echo "[+++] install FlameShot [++++]"
apt install flameshot -y

echo "[++++] Install IP Vanish [++++]"
cd Downloads/
wget https://www.ipvanish.com/software/configs/configs.zip
unzip configs.zip
cd ..
echo "[+++] go set up the VPN network manager and disable IPV6 [++++] "

echo "[*] Install GoLang [*]"
wget https://storage.googleapis.com/golang/go1.13.5.linux-amd64.tar.gz
tar -xvg go1.13.5.linux-amd64.tar.gz
mv go/ /usr/local
export GOROOT=/usr/local/go
export GOPATH=$HOME/mike/go
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH

echo "[====] Install Burp Suite [====]"
wget https://portswigger.net/burp/releases/download?product=community&version=2.1.07&type=linux&componentid=100

echo "[*] Gedit [*]"
apt-get -y install gedit

echo "[*] Install VirtualBox [*]"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian buster contrib"
apt-get -y install virtualbox-6.1
apt-get -y install virtualbox-ext-pack
dpkg -i virtualbox-6.1
echo "[++++] Instructions: Add virtualbox.list to /etc/apt/sources.list.d [++++]"
echo "[++++] deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian buster contrib [++++]"

echo "[*] Install Kali Virtual box torrent [*]"
transmission-cli https://images.offensive-security.com/virtual-images/kali-linux-2019.4-vbox-amd64.ova.torrent -w ~/Downloads

echo "[*] Install Chrome.[*]"
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/
dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb
apt-get -f install -y
dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb

echo "[*] Install Lazy Recon Script [*]"
curl -o lazyrecon.sh https://raw.githubusercontent.com/nahamsec/lazyrecon/master/lazyrecon.sh
dos2unix lazyrecon.sh
chmod +x ./lazyrecon

echo "[*] nstalling Amass [*]"
export GO111MODULE=on
go get -v -u github.com/OWASP/Amass/v3/...
cp $GOPATH/bin/amass /usr/local/bin


echo "[*] Installing Subjack [*] "
go get github.com/haccer/subjack
cp $GOPATH/bin/subjack /usr/local/bin
echo "[*] Finished installing Subjack [*] "

echo "[*] Installing Nmap [*] "
apt-get install -y nmap
echo "[*] Finished installing Nmap [*] "

echo "[+] Installing Waybackurls [+] "
go get github.com/tomnomnom/waybackurls
cp $GOPATH/bin/waybackurls /usr/local/bin
echo "[+] Finished installing Waybackurls [+]"

echo "[+] Installing EyeWitness [+] "
git clone https://github.com/FortyNorthSecurity/EyeWitness.git $HOME/tools/eyewitness
cd $HOME/tools/eyewitness/setup && ./setup.sh

echo "[+] Installing httprobe [+] "
go get -u github.com/tomnomnom/httprobe
cp $GOPATH/bin/httprobe /usr/local/bin
echo "[+] Finished installing httprobe [+] "



echo "[*]Finished Installing All Apps[*]"
