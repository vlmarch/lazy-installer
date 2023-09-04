# Lazy installer

A simple script that allows you to install basic packages and apps. And also configures some system and desktop environment settings.

**Note: This script for the personal use of the author, includes settings (which may not suit you) and dotfiles configured for his needs. Feel free to copy some code parts and fork the repository for your own needs.**

## Manual

1. Create new user:
```bash
su - root
sudo adduser username
```
2. Assign sudo rights to the local user:
```bash
su - root
sudo usermod -aG sudo username
systemctl reboot -i
```
3. [Disable Root Login Over SSH](https://www.howtogeek.com/828538/how-and-why-to-disable-root-login-over-ssh-on-linux/)
4. Switch to the fastest repository mirror
5. Configure the GRUB
    1. Edit the GRUB configuration file: `sudo nano /etc/default/grub`

    ```
    GRUB_TIMEOUT_STYLE=hidden
    GRUB_TIMEOUT=0
    GRUB_CMDLINE_LINUX_DEFAULT="quiet"
    GRUB_BACKGROUND=""
    ```
    2. Update settings: `sudo update-grub`

6. Run Lazy installer

```bash
cd $HOME/Downloads
git clone https://github.com/vlmarch/lazy-installer.git
cd lazy-installer
bash install.sh
```

7. Install additional software from dedicated repositories (such as: miniconda3, rust, ruby, Node.js, Brave, VSCode, Remmina, WineHQ, Joplin, Libreoffice, Kicad, Blender, Arduino IDE etc.)

8. Reboot system


## TODO
- Drivers installation
- Bluetooth configuration
- GStreamer / PulseAudio / PipeWire installation
- Public Key Authentication with SSH
- [Change the Default SSH Port](https://linuxhandbook.com/change-ssh-port/)
- [The 10 Best Methods on How to Improve Linux Security](https://sensorstechforum.com/10-best-methods-improve-linux-security/)
- (Future) Arch Linux packages installation
- (Future) GNOME settings
