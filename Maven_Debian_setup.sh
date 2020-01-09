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
apt-get install -y jq
apt-get install -y ruby-full
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
####Custom to me or my Laptop########
usermod -aG sudo  mike
apt-get -y install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,')
apt-get -y install firmware-linux-nonfree
apt install firmware-linux-nonfree intel-microcode -y
apt install firmware-linux firmware-linux-nonfree libdrm-amdgpu1 xserver-xorg-video-amdgpu -y
apt-get -y install gdebi gksu firmware-linux
apt-get -y install broadcom-sta-dkms 

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

echo "[*] Install VirtualBox [*]"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian buster contrib" 
apt-get -y install virtualbox-6.1
apt-get -y install virtualbox-ext-pack
dpkg -i virtualbox-6.1
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian buster contrib" >> $HOME/etc/apt/sources.list.d

echo "[*] Install Kali Virtual box torrent [*]"
transmission-cli https://images.offensive-security.com/virtual-images/kali-linux-2019.4-vbox-amd64.ova.torrent -w ~/Downloads

echo "[*] Install Chrome.[*]"
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/
dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb
apt-get -f install -y
dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb

echo " [-------------------] Bug Bounty Programs & Scipts [-------------------]"

#create a tools folder in ~/
mkdir ~/tools
cd ~/tools/

echo "installing bash_profile aliases from recon_profile"
git clone https://github.com/nahamsec/recon_profile.git
cd recon_profile
cat bash_profile >> ~/.bash_profile
source ~/.bash_profile
cd ~/tools/
echo "done"

echo "[*] Install Lazy Recon Script [*]"
curl -o lazyrecon.sh https://raw.githubusercontent.com/nahamsec/lazyrecon/master/lazyrecon.sh
dos2unix lazyrecon.sh
chmod +x ./lazyrecon

echo "[====] Install Burp Suite [====]"
wget https://portswigger.net/burp/releases/download?product=community&version=2.1.07&type=linux&componentid=100

echo "[*] Installing Fast web fuzzer (ffuf) [*]"
go get -u github.com/ffuf/ffuf
cp $HOME/go/bin/ffuf /usr/local/bin
    
echo "[*] Installing Amass [*]"
export GO111MODULE=on
go get -v -u github.com/OWASP/Amass/v3/...
cp $HOME/go/bin/amass /usr/local/bin

echo "[+] Installing sublist3r [+]"
git clone https://github.com/aboul3la/Sublist3r.git $HOME/tools/sublist3r
pip3 install --no-cache-dir --install-option="--prefix=/install" -r $HOME/tools/sublist3r/requirements.txt
PATH_EXPORT=$PATH:$HOME/tools/sublist3r
echo $PATH_EXPORT
echo "export PATH=${PATH_EXPORT}" >> $HOME/.bash_profile && source $HOME/.bash_profile
ln -sf $HOME/tools/sublist3r/sublist3r.py $HOME/tools/sublist3r/sublist3r && chmod +x $HOME/tools/sublist3r/sublist3r
echo "[+] Finished installing sublist3r [+]"
    
echo "[*] Installing Subjack [*] "
go get github.com/haccer/subjack
cp $HOME/go/bin/subjack /usr/local/bin
echo "[*] Finished installing Subjack [*] "

echo "[*] Installing Nmap [*] "
apt-get install -y nmap
echo "[*] Finished installing Nmap [*] "

echo "[+] Installing masscan [+]"
git clone https://github.com/robertdavidgraham/masscan $HOME/tools/masscan
cd $HOME/tools/masscan && make -j && cp $HOME/tools/masscan/bin/masscan /usr/local/bin
rm -r $HOME/tools/masscan
cd $HOME
echo "[+] Finished Installing  masscan [+]"

echo "[+] Installing Waybackurls [+] "
go get github.com/tomnomnom/waybackurls
cp $HOME/go/bin/waybackurls /usr/local/bin
echo "[+] Finished installing Waybackurls [+]"

echo "[+] Installing EyeWitness [+] "
git clone https://github.com/FortyNorthSecurity/EyeWitness.git $HOME/tools/eyewitness
cd $HOME/tools/eyewitness/setup && ./setup.sh
cd $HOME

echo "[+] Installing httprobe [+] "
go get -u github.com/tomnomnom/httprobe
cp $HOME/go/bin/httprobe /usr/local/bin
echo "[+] Finished installing httprobe [+] "

echo "[+] Installing Meg [+] "
go get github.com/tomnomnom/meg
cp $HOME/go/bin/meg /usr/local/bin
echo "[+] Finished installing Meg [+]"

echo "[+] Installing Dirsearch [+] "
git clone https://github.com/maurosoria/dirsearch.git
PATH_EXPORT=$PATH:$HOME/tools/dirsearch
echo $PATH_EXPORT
echo "export PATH=${PATH_EXPORT}" >> $HOME/.bash_profile && source $HOME/.bash_profile
ln -sf $HOME/tools/dirsearch/dirsearch.py $HOME/tools/dirsearch/dirsearch && chmod +x $HOME/tools/dirsearch/dirsearch
echo "[+] Finished installing Dirsearch [+] "

echo "[*] Installing aquatone [*]"
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip -O $HOME/tools/aquatone.zip
cd $HOME/tools && unzip aquatone.zip -d $HOME/tools/aquatone && cp $HOME/tools/aquatone/aquatone /usr/local/bin
rm -r $HOME/tools/aquatone && rm $HOME/tools/aquatone.zip
cd $HOME
echo "[+] Finished installing aquatone [+]"

echo "[+] Installing LinkFinder [+] "
git clone https://github.com/GerbenJavado/LinkFinder.git
PATH_EXPORT=$PATH:$HOME/tools/LinkFinder
echo $PATH_EXPORT
echo "export PATH=${PATH_EXPORT}" >> $HOME/.bash_profile && source $HOME/.bash_profile
ln -sf $HOME/tools/LinkFinder/linkfinder.py $HOME/tools/LinkFinder/linkfinder && chmod +x $HOME/tools/LinkFinder/linkfinder
cd LinkFinder
python setup.py install
cd $HOME
echo "[+] Finished installing LinkFinder [+]"

echo "[+] Installing inscope [+] "
go get -u github.com/tomnomnom/hacks/inscope
echo "[+] Finished installing inscope [+]" 
 
echo "[+] Installing MassDNS [+]"
git clone https://github.com/blechschmidt/massdns.git $HOME/tools/massdns
cd $HOME/tools/massdns && make && cp $HOME/tools/massdns/bin/massdns /usr/local/bin
echo "[+] Finished installing MassDNS [+]"
    
echo "[*]Finished Installing All Apps[*]"
