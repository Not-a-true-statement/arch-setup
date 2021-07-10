#!/bin/bash

#Setup time and reset clock
sudo timedatectl set-ntp true
sudo hwclock --systohc

#Setup mirrors for packages
sudo reflector -c Sweden -a 6 --sort rate --save /etc/pacman.d/mirrorlist

#Basic firewall
#sudo firewall-cmd --add-port=1025-65535/tcp --permanent
#sudo firewall-cmd --add-port=1025-65535/udp --permanent
#sudo firewall-cmd --reload

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin/
makepkg -si --noconfirm

#yay -S --noconfirm nvidia-390xx-dkms google-chrome

#DE
sudo pacman -S --noconfirm xorg sddm bspwm sxhkd nitrogen
yay -S --noconfirm polybar

sudo pacman -S --noconfirm sddm
sudo systemctl enable sddm

#Programs
#sudo pacman -S --noconfirm thunderbird obs-studio vlc


sudo flatpak install -y spotify


/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
reboot
