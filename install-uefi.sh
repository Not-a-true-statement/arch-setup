#!/bin/bash

#Locale and language
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen #Might be producing error with the first letter of locale
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

#Network domain
echo "archbook" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 archbook.localdomain archbook" >> /etc/hosts

#Root user
echo root:password | chpasswd


#Basic package installation
    #Booting
    pacman -S grub efibootmgr os-prober
    pacman -S dialog 

    #Disk
    pacman -S mtools dosfstools ntfs-3g

    #Basic Package installation and construction
    pacman -S base-devel linux-headers reflector rsync git

    #Terminal
    pacman -S bash-completion

    #Virtualization + Tools for it
    pacman -S virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils vde2 openbsd-netcat iptables-nft ipset nss-mdns
    pacman -S flatpak

    #Network
    pacman -S networkmanager dnsmasq

    # Audio
    pacman -S jack2 jack2-dbus realtime-privileges qjackctl pulseaudio-jack carla pavucontrol alsa-utils

    #Tools
    

    # pacman -S xf86-video-amdgpu
    # pacman -S nvidia nvidia-utils nvidia-settings


#Bootloader enable
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg



systemctl enable NetworkManager
#systemctl enable bluetooth
#systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
#systemctl enable libvirtd
#systemctl enable firewalld
#systemctl enable acpid

useradd -m tar
echo tar:password | chpasswd
usermod -aG libvirt tar
usermod -aG audio tar
usermod -aG input tar
usermod -aG realtime tar

echo "tar ALL=(ALL) ALL" >> /etc/sudoers.d/tar


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




