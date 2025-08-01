#!/bin/bash

declare -a ConfigItems=("autorandr" "compton.conf" "i3" "sway" "waybar" "shikane" "nvim" "polybar" "rofi")

# Read the array values with space
for config_item in "${ConfigItems[@]}"; do
    ln -s ".config/$config_item" "$HOME/.config/$config_item"
done

sudo apt install sway-notification-center

cp .config/sway/sway-session.target $HOME/.config/systemd/user/sway-session.target
# cp .config/shikane/shikane.service $HOME/.config/systemd/user/shikane.service

echo "https://github.com/lsd-rs/lsd/releases"

mkdir "$HOME/bin"
ln -s "bin/readcert" "$HOME/bin/readcert"
