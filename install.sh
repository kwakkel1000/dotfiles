#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse optional flag
DO_LINKS=true
while getopts ":l" opt; do
    case $opt in
    l) DO_LINKS=true ;; # Always true unless you add a no-links flag
    \?)
        echo "Usage: $0 [-l] ( -l runs only links)"
        exit 1
        ;;
    esac
done

declare -a ConfigItems=("autorandr" "compton.conf" "i3" "sway" "waybar" "shikane" "nvim" "polybar" "rofi" "alacritty")

# Read the array values with space
for config_item in "${ConfigItems[@]}"; do
    ln -sf "$SCRIPT_DIR/.config/$config_item" "$HOME/.config/$config_item"
done

ln -sf "$SCRIPT_DIR/.config/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$SCRIPT_DIR/bin/readcert" "$HOME/.local/bin/readcert"
ln -sf "$SCRIPT_DIR/bin/code-mux" "$HOME/.local/bin/code-mux"

if [ "$DO_LINKS" = false ]; then
    sudo apt install sway-notification-center tmux
    cp "$SCRIPT_DIR/.config/sway/sway-session.target" "$HOME/.config/systemd/user/sway-session.target"
    echo "https://github.com/lsd-rs/lsd/releases"
fi
