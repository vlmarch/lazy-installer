#!/bin/bash

echo
echo '     __                         _            __        ____          '
echo '    / /   ____ _____  __  __   (_)___  _____/ /_____ _/ / /__  _____ '
echo '   / /   / __ `/_  / / / / /  / / __ \/ ___/ __/ __ `/ / / _ \/ ___/ '
echo '  / /___/ /_/ / / /_/ /_/ /  / / / / (__  ) /_/ /_/ / / /  __/ /     '
echo ' /_____/\__,_/ /___/\__, /  /_/_/ /_/____/\__/\__,_/_/_/\___/_/      '
echo '                   /____/                                            '
echo
sudo echo # sudo Permissions

# ------------------------------------------------------------------------------

# Security
# https://sensorstechforum.com/10-best-methods-improve-linux-security/


# sudo apt install libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi

# GStreamer
# sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio


# https://github.com/pablopunk/fresh-install/blob/master/fresh-install.sh

# TODO: Create new user: sudo useradd -m username; Add the user to the sudo group: sudo usermod -a -G sudo username
# TODO: Switch to the fastest repository mirror
# TODO: Public Key Authentication with SSH
# TODO: Disable Root Login Over SSH
# TODO: Change the Default SSH Port
# TODO: wine etc....

        # sudo dpkg --add-architecture i386

        # libgl1-mesa-glx:i386

        # https://forums.debian.net/viewtopic.php?t=110962
        # https://stackoverflow.com/questions/55313610/importerror-libgl-so-1-cannot-open-shared-object-file-no-such-file-or-directo


        # sudo apt install -y ia32-libs

        # Для Ubuntu и других дистрибутивов, основанных на Debian, необходимо добавить 32-битную архитектуру и установить необходимые пакеты, например выполнив в терминале:

        # sudo apt install -y libgl1-mesa-glx:i386 libasound2-plugins:i386 libfontconfig1:i386 libsdl2-2.0-0:i386 libopenal1:i386

# ------------------------------------------------------------------------------

# Swappiness settings
# sysctl -w vm.swappiness=10

# GRUB config

# ------------------------------------------------------------------------------


# Varibels

# Functions
function install_if_not_exist() {
    if dpkg -s "$1" &>/dev/null; then
        PKG_EXIST=$(dpkg -s "$1" | grep "install ok installed")
        if [[ -n "$PKG_EXIST" ]]; then
            echo "$1 - is already installed."
            return
        fi
    fi
    echo "$1 - installation..."
    sudo apt install "$1" -y
}


# ------------------------------------------------------------------------------

# Check operating system
if [ "$(uname)" != "Linux" ]; then
    exit 1
fi

# Check package manager
if [[ $(command -v apt) ]]; then
    echo "APT detected"
    echo

    sudo apt update && sudo apt upgrade -y

    # TODO: Drivers
    # # Install tool for hardware detection
    # sudo apt install nvidia-detect

    # # Perform the scan
    # sudo nvidia-detect

    # # Install recommended driver. It is nvidia-driver for me. Yours could be different.
    # sudo apt install nvidia-driver

    # # Similar to NVIDIA, AMD offers its drivers which are also very easy to install.
    # sudo apt install firmware-linux firmware-linux-nonfree libdrm-amdgpu1 xserver-xorg-video-amdgpu
    # # If you play games, I would also recommend installing support for Vulkan.
    # sudo apt install mesa-vulkan-drivers libvulkan1 vulkan-tools vulkan-validationlayers

    # microcode firmware
    install_if_not_exist intel-microcode
    # install_if_not_exist amd64-microcode

    # Firewall
    # https://christitus.com/linux-security-mistakes/
    install_if_not_exist ufw
    install_if_not_exist gufw
    if ! [[ $(sudo ufw status | grep -w active) ]]; then
        sudo ufw enable
    fi

    # Battery life
    # install_if_not_exist tlp
    # install_if_not_exist powertop

    # Printers
    install_if_not_exist cups
    install_if_not_exist cups-pdf
    install_if_not_exist ghostscript

    echo
    echo "Development tools installation"
    echo

    install_if_not_exist curl
    install_if_not_exist apt-transport-https
    install_if_not_exist build-essential
    install_if_not_exist cmake
    install_if_not_exist dkms
    install_if_not_exist linux-headers # Debian ???
    install_if_not_exist git
    install_if_not_exist neofetch
    install_if_not_exist colortest
    install_if_not_exist gnome-themes-extra
    install_if_not_exist gtk2-engines-murrine
    install_if_not_exist sassc

    echo
    echo "APT tools"
    echo

    # Rootkit detector
    install_if_not_exist chkrootkit
    # install_if_not_exist rkhunter
    # install_if_not_exist clamav

    # System monitor
    install_if_not_exist htop
    # install_if_not_exist bashtop
    # install_if_not_exist btop

    # Network monitor
    install_if_not_exist iftop
    # install_if_not_exist bmon
    # install_if_not_exist slurm
    # install_if_not_exist tcptrack
    # install_if_not_exist vnstat

    # Package manager / Graphical package manager
    # install_if_not_exist nala
    # install_if_not_exist synaptic

    # File manager
    # install_if_not_exist ranger

    # Disk Usage
    install_if_not_exist ncdu

    # Archive manager / Console Compression Tools
    # install_if_not_exist rar
    install_if_not_exist unrar
    install_if_not_exist zip
    install_if_not_exist unzip
    install_if_not_exist p7zip
    install_if_not_exist lzop

    # Other tools
    install_if_not_exist tree
    install_if_not_exist exa
    install_if_not_exist bat
    # install_if_not_exist conky
    # install_if_not_exist rofi
    # install_if_not_exist tmux
    # install_if_not_exist putty
    # install_if_not_exist fzf
    # install_if_not_exist fd-find
    # install_if_not_exist ripgrep

    # Apps
    install_if_not_exist thunderbird # E-Mails application
    install_if_not_exist virt-manager # Virtual Machine Manager
    install_if_not_exist liferea # RSS Readers
    # install_if_not_exist newsboat # CLI RSS Readers

    # Just for fun
    # install_if_not_exist fortune
    # install_if_not_exist cowsay
    # install_if_not_exist hollywood
    # install_if_not_exist cmatrix

    # ZSH and ZSH plugins
    install_if_not_exist zsh
    install_if_not_exist zsh-syntax-highlighting
    install_if_not_exist zsh-autosuggestions

    # spaceship-prompt installation
    mkdir -p "$HOME/.zsh"
    git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME/.zsh/spaceship"

    if ! [ $SHELL = '/bin/zsh' ]; then
        chsh -s $(which zsh)
    fi

    # Fonts
    install_if_not_exist ttf-mscorefonts-installer # Debian ???
    install_if_not_exist fonts-ubuntu # Debian ???
    # install_if_not_exist fonts-firacode
    install_if_not_exist fonts-hack
    # install_if_not_exist fonts-jetbrains-mono
    install_if_not_exist fonts-inconsolata
    # install_if_not_exist fonts-terminus
    # install_if_not_exist fonts-crosextra-caladea
    # install_if_not_exist fonts-crosextra-carlito
    # install_if_not_exist fonts-wine
    # install_if_not_exist fonts-freefont-ttf
    # install_if_not_exist fonts-dejavu
    # install_if_not_exist fonts-roboto

    sudo apt autoclean -y && sudo apt autoremove -y

elif [[ $(command -v packman) ]]; then
    echo "pacman detected"

    echo "WIP (Work in Progress)"
    exit 1

else
    echo "Script only supports APT and packman!"
    exit 1
fi

if [ $XDG_CURRENT_DESKTOP = "XFCE" ]; then
    echo "Configure XFCE"
    # TODO: Kali linux

    # thunar
    xfconf-query -c thunar -p "/default-view" -s "ThunarCompactView"
    xfconf-query -c thunar -p "/misc-change-window-icon" -s true
    xfconf-query -c thunar -p "/misc-date-style" -s "THUNAR_DATE_STYLE_YYYYMMDD"
    xfconf-query -c thunar -p "/misc-directory-specific-settings" --create --type bool -s false
    xfconf-query -c thunar -p "/misc-single-click" -s false
    xfconf-query -c thunar -p "/misc-small-toolbar-icons" --create --type bool -s true
    xfconf-query -c thunar -p "/misc-text-beside-icons" -s false
    xfconf-query -c thunar -p "/misc-thumbnail-draw-frames" -s false
    xfconf-query -c thunar -p "/misc-thumbnail-mode" -s "THUNAR_THUMBNAIL_MODE_ALWAYS"
    xfconf-query -c thunar -p "/misc-volume-management" -s true
    xfconf-query -c thunar -p "/shortcuts-icon-emblems" -s true
    xfconf-query -c thunar -p "/shortcuts-icon-size" -s "THUNAR_ICON_SIZE_16"
    xfconf-query -c thunar -p "/tree-icon-emblems" -s true
    xfconf-query -c thunar -p "/misc-recursive-search" -s "THUNAR_RECURSIVE_SEARCH_ALWAYS"

    # xfce4-appfinder
    xfconf-query -c xfce4-appfinder -p "/always-center" -s true
    xfconf-query -c xfce4-appfinder -p "/category-icon-size" -s 0
    xfconf-query -c xfce4-appfinder -p "/enable-service" -s true
    xfconf-query -c xfce4-appfinder -p "/hide-category-pane" -s false
    xfconf-query -c xfce4-appfinder -p "/icon-view" -s true
    xfconf-query -c xfce4-appfinder -p "/item-icon-size" -s 0
    xfconf-query -c xfce4-appfinder -p "/single-window" -s true
    xfconf-query -c xfce4-appfinder -p "/text-beside-icons" -s true

    # xfce4-desktop
    xfconf-query -c xfce4-desktop -p "/desktop-icons/file-icons/show-filesystem" -s false
    xfconf-query -c xfce4-desktop -p "/desktop-icons/file-icons/show-home" -s false
    xfconf-query -c xfce4-desktop -p "/desktop-icons/file-icons/show-removable" -s false
    xfconf-query -c xfce4-desktop -p "/desktop-icons/file-icons/show-trash" -s false
    xfconf-query -c xfce4-desktop -p "/desktop-icons/icon-size" -s 36
    xfconf-query -c xfce4-desktop -p "/desktop-icons/show-hidden-files" -s false
    xfconf-query -c xfce4-desktop -p "/desktop-icons/show-thumbnails" -s true
    xfconf-query -c xfce4-desktop -p "/desktop-icons/show-tooltips" -s false
    xfconf-query -c xfce4-desktop -p "/desktop-icons/primary" -s false
    xfconf-query -c xfce4-desktop -p "/desktop-icons/use-custom-font-size" -s true
    xfconf-query -c xfce4-desktop -p "/desktop-icons/font-size" -s 9


    # xfce4-keyboard-shortcuts
    # Create commands
    xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/override" -s true
    xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>e" -n -t string -s "thunar"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>s" -n -t string -s "xfce4-popup-whiskermenu"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>l" -n -t string -s "xflock4"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>i" -n -t string -s "xfce4-settings-manager"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Alt>Delete" -n -t string -s "xfce4-taskmanager"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Alt>Escape" -n -t string -s "xkill"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Alt>t" -n -t string -s "x-terminal-emulator"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary>space" -n -t string -s "rofi -show drun"

    # Reset default shortcuts
    for property in $(xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom" -l)
    do xfconf-query -c xfce4-keyboard-shortcuts -p $property -r; done

    # Create shortcuts
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/override" -n -t bool -s true
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>d" -n -t string -s "show_desktop_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>Tab" -n -t string -s "cycle_windows_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Super>Tab" -n -t string -s "cycle_reverse_windows_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>Down" -n -t string -s "tile_down_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>Left" -n -t string -s "tile_left_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>Right" -n -t string -s "tile_right_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>Up" -n -t string -s "tile_up_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Super>d" -n -t string -s "add_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Super>F4" -n -t string -s "del_active_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Super>Down" -n -t string -s "down_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Super>Left" -n -t string -s "left_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Super>Right" -n -t string -s "right_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Super>Up" -n -t string -s "up_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Control>F1" -n -t string -s "workspace_1_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Control>F2" -n -t string -s "workspace_2_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Control>F3" -n -t string -s "workspace_3_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Control>F4" -n -t string -s "workspace_4_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Down" -n -t string -s "move_window_down_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Left" -n -t string -s "move_window_left_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Right" -n -t string -s "move_window_right_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Up" -n -t string -s "move_window_up_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt><Control>Home" -n -t string -s "move_window_prev_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt><Control>End" -n -t string -s "move_window_next_workspace_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt><Control>KP_1" -n -t string -s "move_window_workspace_1_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt><Control>KP_2" -n -t string -s "move_window_workspace_2_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt><Control>KP_3" -n -t string -s "move_window_workspace_3_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt><Control>KP_4" -n -t string -s "move_window_workspace_4_key"

    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>space" -n -t string -s "popup_menu_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/Up" -n -t string -s "up_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/Down" -n -t string -s "down_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/Left" -n -t string -s "left_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/Right" -n -t string -s "right_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/Escape" -n -t string -s "cancel_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>F4" -n -t string -s "close_window_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>F10" -n -t string -s "maximize_window_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>F9" -n -t string -s "hide_window_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>F8" -n -t string -s "resize_window_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>F7" -n -t string -s "move_window_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>F6" -n -t string -s "stick_window_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Alt>Page_Up" -n -t string -s "raise_window_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Alt>Page_Down" -n -t string -s "lower_window_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>F11" -n -t string -s "fullscreen_key"
    xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>F12" -n -t string -s "above_key"


    # xfce4-panel
    xfconf-query -c xfce4-panel -p "/panels/dark-mode" -s true

    # xfwm4 (TODO)
    xfconf-query -c xfwm4 -p "/general/click_to_focus" -s true
    xfconf-query -c xfwm4 -p "/general/double_click_action" -s "maximize"
    xfconf-query -c xfwm4 -p "/general/focus_hint" -s true
    xfconf-query -c xfwm4 -p "/general/focus_new" -s true
    xfconf-query -c xfwm4 -p "/general/show_dock_shadow" -s true

    # xsettings
    xfconf-query -c xsettings -p "/Gtk/ButtonImages" -s false
    xfconf-query -c xsettings -p "/Gtk/DialogsUseHeader" -s true
    xfconf-query -c xsettings -p "/Gtk/MenuImages" -s false

elif [ $XDG_CURRENT_DESKTOP = "GNOME" ]; then
    echo "GNOME not supported :("
    # echo "Configure GNOME"
    # install_if_not_exist gnome-tweak-tool
    # install_if_not_exist chrome-gnome-shell
    exit 1
else
    echo "Script only supports XFCE!"
    exit 1
fi

# Dotfiles
mkdir -p "$HOME/Documents/GitHub"
if [ ! -d "$HOME/Documents/GitHub/dotfiles" ]; then
    git clone https://github.com/vlmarch/dotfiles.git "$HOME/Documents/GitHub/dotfiles"
    bash "$HOME/Documents/GitHub/dotfiles/install.sh"
fi


# Install miniconda3 # Debian ???
if [ ! -d "$HOME/miniconda3" ]; then
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh
fi

# Install Rust and Cargo
if [ ! -d "$HOME/.cargo" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# TODO: Install Ruby
# TODO: Install Node.js

# TODO: Additional software Note
# Brave, VSCode, Remmina, WineHQ, Joplin, Libreoffice, Kicad, Blender, Arduino IDE etc.
