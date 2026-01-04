# do

sudo apt update 
sudo apt upgrade
sudo apt install git ripgrep imagemagick wlogout sway swaybg swayidle swayimg swaylock waybar wofi fonts-font-awesome curl wget lsd stow fzf pulseaudio pulseaudio-utils wf-recorder blueman bluez bluez-obexd redshift -y
sudo snap install yazi --classic
sudo snap install zig --classic --beta
sudo snap install nvim --classic
sudo snap install btop

# install starship
curl -sS https://starship.rs/install.sh | sh

bash ./scripts/install_font.sh
bash ./scripts/install_sway_screenshot.sh
# fc-list | grep "Fira Mono Nerd Font"
# install wezterm

# instalation location of third-party apps => ~/Apps/
