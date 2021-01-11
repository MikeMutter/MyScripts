#!/bin/bash

logo(){
  #against the law to have a batch script without a cool logo :D
  echo "${red}
      ||\\  //||   //\\  \\    // ||''' ||\\  || 
      || \\// ||  //==\\  \\  //  ||==  || \\ ||
      ||      || //    \\  \\//   ||,,, ||  \\||             
${reset}                                     "
}
########################################################################
# Date: 01/09/2020
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
apt-get -y rar
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
apt-get install -y git
apt-get install -y rename
apt-get install -y xargs
pip3 install -y jsbeautifier

##Antivirus and IDS##
echo "[*] Install ClamAV [*]"
apt get install clamav -y 
apt get install snort -y
echo "[*] Finished installing ClamAV [*]"
#############################

##################
echo "[*] Install GoLang [*]"
wget https://storage.googleapis.com/golang/go1.13.5.linux-amd64.tar.gz
tar -xvg go1.13.5.linux-amd64.tar.gz
mv go/ /usr/local
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
echo "export GOROOT=/usr/local/go" >> ~/.bash_profile 
echo "export GOPATH=$HOME/go" >> ~/.bash_profile 
echo "export PATH=$GOROOT/bin:$GOPATH/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile
apt install sudo -y

####Custom to my Laptop########
usermod -aG sudo  mike
apt-get -y install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,')
apt-get -y install firmware-linux-nonfree
apt install firmware-linux-nonfree intel-microcode -y
apt install firmware-linux firmware-linux-nonfree libdrm-amdgpu1 xserver-xorg-video-amdgpu -y
apt-get -y install gdebi gksu firmware-linux

echo "[++++] Install IP Vanish [++++]"
cd Downloads/
wget https://www.ipvanish.com/software/configs/configs.zip
unzip configs.zip
cd ..
echo "[+++] go set up the VPN network manager and disable IPV6 [++++] "

echo "[+++] Set up firewall [++++]"
apt-get -y install ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable
#####################################

echo "[+++] install FlameShot [++++]"
apt install flameshot -y

echo "[*] Gedit [*]"
apt-get -y install gedit

echo "[*] Install Chrome.[*]"
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/
dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb
apt-get -f install -y
dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb


echo "[====] Install Burp Suite [====]"
cd ~
wget https://portswigger.net/burp/releases/download?product=community&version=2.1.07&type=linux&componentid=100
    
echo "[*] Installing Amass [*]"
export GO111MODULE=on
go get -v -u github.com/OWASP/Amass/v3/...
cp $HOME/go/bin/amass /usr/local/bin

echo "[+] Installing sublist3r [+]"
git clone https://github.com/aboul3la/Sublist3r.git $HOME/sublist3r
pip3 install --no-cache-dir --install-option="--prefix=/install" -r $HOME/sublist3r/requirements.txt
PATH_EXPORT=$PATH:$HOME/sublist3r
echo $PATH_EXPORT
echo "export PATH=${PATH_EXPORT}" >> $HOME/.bash_profile && source $HOME/.bash_profile
ln -sf $HOME/sublist3r/sublist3r.py $HOME/sublist3r/sublist3r && chmod +x $HOME/sublist3r/sublist3r
echo "[+] Finished installing sublist3r [+]"

echo "[*] Installing Nmap [*] "
apt-get install -y nmap
echo "[*] Finished installing Nmap [*] "

echo "[+] Installing Dirsearch [+] "
git clone https://github.com/maurosoria/dirsearch.git
PATH_EXPORT=$PATH:$HOME/dirsearch
echo $PATH_EXPORT
echo "export PATH=${PATH_EXPORT}" >> $HOME/.bash_profile && source $HOME/.bash_profile
ln -sf $HOME/dirsearch/dirsearch.py $HOME/dirsearch/dirsearch && chmod +x $HOME/dirsearch/dirsearch
echo "[+] Finished installing Dirsearch [+] "

echo "[+] Installing and starting OWASP ZAP [+]"
wget https://github.com/zaproxy/zaproxy/releases/download/w2020-01-27/ZAP_WEEKLY_D-2020-01-27.zip
unzip ZAP_WEEKLY_D-2020-01-27.zip
echo "[+] Finished installing OWASP ZAP [+]"
    
echo "[*]Finished Installing All Apps[*]"
