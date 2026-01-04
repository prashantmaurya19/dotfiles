#!/bin/bash
FONT_NAME="FiraCode.zip"
URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/$FONT_NAME"
# download the FiraCode font and install it
wget -P ~/Downloads/ $URL
unzip ~/Downloads/$FONT_NAME -d ~/Downloads/FontCache
# mkdir -p ~/.local/share/fonts/FiraCodeNerdFont
mv ~/Downloads/FontCache/*.ttf ~/.fonts/
fc-cache -f -v
rm -rf ~/Downloads/FontCache
rm ~/Downloads/$FONT_NAME
echo "$FONT_NAME installed successfully!"
