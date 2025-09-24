#!/bin/bash

declare -a ConfigItems=("autorandr" "compton.conf" "i3" "sway" "waybar" "shikane" "nvim" "polybar" "rofi" "alacritty")

# Read the array values with space
for config_item in "${ConfigItems[@]}"; do
    ln -s "$HOME/dotfiles/.config/$config_item" "$HOME/.config/$config_item"
done

ln -s "$HOME/dotfiles/.config/.tmux.conf" "$HOME/.tmux.conf"

sudo apt install sway-notification-center tmux

cp .config/sway/sway-session.target $HOME/.config/systemd/user/sway-session.target
# cp .config/shikane/shikane.service $HOME/.config/systemd/user/shikane.service

echo "https://github.com/lsd-rs/lsd/releases"

ln -s "bin/readcert" "$HOME/.local/bin/readcert"
