#!/bin/bash

name=$(whoami)

echo "Welcome $name."
sleep 1
echo "This script will setup your apps and services for Arch Linux."



while true; do
    read -p  "Continue? (y/n): " yn
    case $yn in 
        [Yy]* ) echo "Beginning system configuration..." ; break ;;

        [Nn]* ) echo "Installation aborted." ; exit ;;

        *     ) continue ;;

    esac
done

echo "Performing full system upgrade..."
sudo pacman -Syu

echo "Installing package tools..."
sleep 1
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
sudo pacman -S flatpak



echo "Installing tools and services..."
sleep 1

utils=(
    btop
    calf
    cava
    dolphin
    easyeffects
    fish
    fprintd
    gnome-keyring
    hyprshot
    kitty
    libre-office-fresh
    lsp-plugins
    mission-center
    ncdu
    nvim
    nwg-look
    pavucontrol
    plasma-plasma-systemmonitor
    playerctl
    python-pipx
    qt6ct
    seahorse
    shotwell
    starship
    tailscale
)

sudo pacman -S --needed "${utils[@]}"

echo "Installing integrations..."
sleep 1

integrations=(
    kdeconnect
    nextcloud-client
    tailscale
)

sudo pacman -S --needed "${integrations[@]}"

echo "Installing apps..."
sleep 1

apps=(
    chromium
    discord
    firefox
    firefoxpwa
    inkscape
    kdenlive
    prismlauncher
    steam    
)

sudo pacman -S --needed "${apps[@]}"

aurapps=(
    teams-for-linux-bin
    sone-bin
    hyprmoncfg
)

paru -S --needed "${aurapps[@]}"

echo "Installing GUIs..."
sleep 1

sudo pacman -S --needed hyprland noctalia
paru -S darkly 

echo "Configuring services..."
sleep 1

sudo chsh -s /bin/fish
systemctl --user enable hyprmoncfgd


echo "Done! Your system is now configured. Reboot required for changes to take full effect."

echo "Reboot now? (y/n) : "

while true; do
    read reboot
    case $reboot in
        [Yy]* ) echo "Rebooting!" ; sudo reboot ;;
        [Nn]* ) echo "Exiting the script" ; exit ;;
        *     ) continue ;;
    esac
done
