#!/bin/bash

#quick setup script for getting files and settings to preference

#check for file conflict before downloading
if [ -f .bashrc ]; then
	mv .bashrc .bashrc.old
fi

if [ -f .vimrc ]; then
	mv .vimrc .vimrc.old
fi

#get required files
wget https://raw.githubusercontent.com/ethanhen/ewhLinuxScripts/main/graphicsfix.sh
wget https://raw.githubusercontent.com/ethanhen/ewhLinuxScripts/main/.bashrc
wget https://raw.githubusercontent.com/ethanhen/ewhLinuxScripts/main/.vimrc
wget https://raw.githubusercontent.com/GideonWolfe/Zathura-Pywal/master/genzathurarc
wget https://raw.githubusercontent.com/GideonWolfe/Zathura-Pywal/master/zathura
wget -O zathura-color.sh https://raw.githubusercontent.com/GideonWolfe/Zathura-Pywal/master/install.sh

chmod +x graphicsfix.sh
chmod +x zathura-color.sh

#make sure packages are installed and updated
apt-get -y update && apt-get upgrade
apt-get -y install vim zathura python-is-python3 python3-pip python2 youtube-dl ffmpeg neofetch net-tools curl git

#install other tools
pip3 install pywal
pip3 install gallery-dl

#set wal theme for terminal
wal --theme base16-nord

#VIM CONFIGURATIONS
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.vim/UltiSnips && wget https://raw.githubusercontent.com/gillescastel/latex-snippets/master/tex.snippets && mv tex.snippets ~/.vim/UltiSnips/tex.snippets

#run the zathura fix and the hyper-v settings fix
/bin/bash zathura-color.sh
/bin/bash graphicsfix.sh

#ensure autologin is off
sed -i '/AutomaticLoginEnable = true/c\#  AutomaticLoginEnable = true' /etc/gdm3/custom.conf
sed -i '/AutomaticLogin = user1/c\#  AutomaticLogin = user1' /etc/gdm3/custom.conf

#install vim plugins
vim +PlugInstall +qall

#clean up
rm graphicsfix.sh
rm zathura-color.sh
