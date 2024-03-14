#!/bin/bash

declare -a ConfigItems=("autorandr" "compton.conf" "i3" "nvim" "polybar" "rofi")

# Read the array values with space
for config_item in "${ConfigItems[@]}"; do
    ln -s ".config/$config_item" "$HOME/.config/$config_item"
done

echo "https://github.com/lsd-rs/lsd/releases"
