#!/bin/bash

sudo apt update
sudo apt upgrade
sudo apt install git ripgrep pipx build-essential imagemagick wlogout sway swaybg swayidle swayimg swaylock waybar wofi fonts-font-awesome curl wget lsd stow fzf pulseaudio pulseaudio-utils wf-recorder blueman bluez bluez-obexd redshift -y
sudo snap install yazi --classic
sudo snap install zig --classic --beta
sudo snap install nvim --classic
sudo snap install btop

# run below command in case of error by pipx while installing the waypaper
# sudo apt install python3-dev pkg-config libcairo2-dev libgirepository-2.0-dev -y

pipx install waypaper

# install starship
curl -sS https://starship.rs/install.sh | sh

python3 -m venv ~/.venv
source ~/.venv/bin/activate
pip install pywal
deactivate

bash ./scripts/install_font.sh
bash ./scripts/install_sway_screenshot.sh
bash ./scripts/update_wallpaper_link.sh ~/Pictures/mountain-landscape-5120x2880-24317.jpg

# instalation location of third-party apps => ~/Apps/
# fc-list | grep "Fira Mono Nerd Font"
# install wezterm
