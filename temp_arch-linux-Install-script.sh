# #!/bin/bash



# # - [Choosing the Right Linux Distro](https://christitus.com/choose-linux-distro/)
# # - [5 Tools to Easily Create a Custom Linux Distro](https://www.maketecheasier.com/6-tools-to-easily-create-your-own-custom-linux-distro/)

# # - Arch Linux Install
# #     - https://github.com/Antiz96/Arch-Linux-Install-Script/blob/main/install-arch-linux.sh
# #     - https://gitlab.com/eflinux/arch-basic/-/blob/master/base-uefi.sh
# #     - https://gitlab.com/eflinux/arch-basic/-/blob/master/base-mbr.sh
# #     - https://www.youtube.com/watch?v=YbXHU7W7Its
# #     - https://www.youtube.com/c/EFLinuxMadeSimple
# #     - https://www.youtube.com/c/ChrisTitusTech

# https://github.com/archlinux/archinstall

# ###############################################################################
# ####################### Arch Linux installation ###############################
# ###############################################################################

# #################### Console conf ########################

# # localectl list-keymaps # list keymaps
# # localectl list-keymaps | grep pl # list keymaps filterd pl

# loadkeys pl
# setfont ter-116n

# #################### Internet conection ########################

# # Test Internet connection
# pacman -Sy

# # Show IP
# ip -c a

# # For WIFI connection (WIP)
# # iwctl
# # station wlan0 connect WifiName

# ##############################################################

# # Update the system clock
# timedatectl set-ntp true
# timedatectl set-timezone Europe/Warsaw
# timedatectl status

# ################ Partition the disks #########################

# # Check Disk
# lsblk # or fdisk -l

# gdisk /dev/sdX # replace sdX with your disk name


# # GPT fdisk (gdisk) version 1.0.5

# # Partition table scan:
# #  MBR: not present
# #  BSD: not present
# #  APM: not present
# #  GPT: not present

# # Creating new GPT entries in memory.

# # Command (? for help): n
# # Partition number (1-128, default 1)
# # First sector (34-976773134, default = 2048) or {+-}size{KMGTP}:
# # Last sector (2048-976773134, default = 976773134) or {+-}size{KMGTP}: +300M # +300M / +512M for UEFI partition !!!!!!!!  524MB Dell ubuntu
# # Current type is 8300 (Linux filesystem)
# # Hex code or GUID (L to show codes, Enter = 8300): ef00 # !!!!!!!!!!!!!!!
# # Changed type of partition to 'EFI system partition'

# # Command (? for help): n
# # Partition number (2-128, default 2):
# # First sector (34-976773134, default = 1050624) or {+-}size{KMGTP}:
# # Last sector (1050624-976773134, default = 976773134) or {+-}size{KMGTP}:↵ +1G # for SWAP partition https://itsfoss.com/swap-size/
# # Current type is 8300 (Linux filesystem)
# # Hex code or GUID (L to show codes, Enter = 8300): 8200 # !!!!!!!!!!!!!
# # Changed type of partition to 'Linux swap'

# # Command (? for help): n
# # Partition number (2-128, default 3):
# # First sector (34-976773134, default = 1050624) or {+-}size{KMGTP}:
# # Last sector (1050624-976773134, default = 976773134) or {+-}size{KMGTP}: +30G # root partition /  +65G Users recommended
# # Current type is 8300 (Linux filesystem)
# # Hex code or GUID (L to show codes, Enter = 8300):
# # Changed type of partition to 'Linux filesystem'

# # Command (? for help): n
# # Partition number (2-128, default 3):
# # First sector (34-976773134, default = 1050624) or {+-}size{KMGTP}:
# # Last sector (1050624-976773134, default = 976773134) or {+-}size{KMGTP}: # home partition
# # Current type is 8300 (Linux filesystem)
# # Hex code or GUID (L to show codes, Enter = 8300):
# # Changed type of partition to 'Linux filesystem'

# # Command (? for help): w


# ############### Format the partitions ###############################

# mkfs.vfat /dev/sdX1 # replace sdX1 with your UEFI partition name
# mkswap /dev/sdX2 # replace sdX2 with your SWAP partition name
# swapon /dev/sdX2 # for activate your SWAP partition (replace sdX2 with your SWAP partition name)
# mkfs.ext4 /dev/sdX3 # replace sdX3 with your root partition name
# mkfs.ext4 /dev/sdX4 # replace sdX4 with your home partition name


# ############### Mount the file systems ############################

# mount /dev/sdX3 /mnt # firstly mount ROOT partition (replace sdX3 with your root partition name)
# mkdir -p /mnt/{boot/efi,home}
# mount /dev/sdX1 /mnt/boot/efi
# mount /dev/sdX4 /mnt/home

# ################# Select the mirrors ###############################



# ################ Install essential packages ########################

# pacstrap /mnt base linux linux-firmware nano intel-ucode # git vim amd-ucode


# ############### Generate an fstab file ##############################

# genfstab -U /mnt >> /mnt/etc/fstab


# ############### Change root into the new system ####################
# arch-chroot /mnt

# ####################################################################

# ############### Set Time Zone ###########
# ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime

# #### sthyn hardware clock vs system clock
# hwclock --systohc

# nano /etc/locale.gen
# # select loc and save file
# locale-gen # Generate locale
# echo "LANG=en_US.UTF-8" >> /etc/locale.conf
# echo "KEYMAP=pl" >> /etc/vconsole.conf
# echo "arch" >> /etc/hostname # set host name

# ######## hosts editor ?????
# nano /etc/hosts

# # Add lines
# # 127.0.0.1[tab]localhost
# # ::1[tab][tab]localhost
# # 127.0.1.1[tab]arch.localhost[tab]arch # arch - hostname

# ########3 Set password for root ###########3
# passwd

# ##################### instaling packeges

# # Boot loader
# pacman -S grub efibootmgr


# # Network
# pacman -S networkmanager network-manager-applet # systemd-networkd
# systemctl enable NetworkManager

# # WiFi ???
# pacman -S wpa_supplicant

# # Generic / Dev packeges
# base-devel linux-headers dialog
# nano vim
# neofetch

# # options+=("pacman-contrib" "Pacman contrib tools" on)
# # options+=("bash-completion" "Completion for bash" on)
# # options+=("usbutils" "USB Device Utilities" on)
# # options+=("lsof" "ls open file" on)
# # options+=("dmidecode" "Hardware infos" on)
# # options+=("linux-firmware" "Firmware files for Linux" off)
# # options+=("nmon" "System monitor" off)
# # options+=("mc" "Dual pane file explorer" off)
# # options+=("fwupd" "Firmware upgrade" off)
# # options+=("powertop" "power mon and management" off)
# # options+=("gpm" "Console mouse support" off)
# # options+=("liveroot" "(AUR) root overlay fs" off)

# # users homedir / xdg
# # xdg-user-dirs xdg-utils

# # Console Compression Tools
# pacman -S zip unzip unrar p7zip lzop

# # Bluthooth
# pacman -S bluez bluez-utils
# systemctl enable bluetooth

# # Printers
# pacman -S cups ghostscript cups-pdf # hplip  # HP Printers
# systemctl enable cups # systemctl enable cups.service

# # Sound (pulseaudio)
# pacman -S alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pavucontrol

# # Sound (pipewire)
# pacman -S alsa-utils alsa-plugins pipewire pipewire-alsa pipewire-pulse pipewire-jack pipewire-media-session pavucontrol


# ############ XFCE ###################

# # Xorg
# pacman -S xorg-server xorg-xinit

# # Display Manager
# pacman -S lightdm lightdm-gtk-greeter
# systemctl enable lightdm.service

# # xfce4
# pacman -S xfce4 xfce4-goodies


# ############# GNOME #####################

# # Wayland
# pacman -S wayland

# # Display Manager
# pacman -S gdm
# systemctl enable gdm.service

# # GNOME
# pacman -S gnome gnome-extra


# # Fonts
# terminus-font fonts-hack # fonts-terminus

# #################33 install GRUB bootloader ##################################
# # grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
# grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
# #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi

# grub-mkconfig -o /boot/grub/grub.cfg



# ############ add user ####################################3
# useradd -m user_name
# passwd user_name #echo user_naem:password | chpasswd

# EDITOR=nano visudo # and uncomment "ALL=(ALL) ALL"  / ??? or echo "ermanno ALL=(ALL) ALL" >> /etc/sudoers.d/ermanno

# usermod -aG wheel user_name # usermod -aG libvirt ermanno

# ################33 unmount and reboot ###########################3
# exit
# unmount -R /mnt
# reboot
