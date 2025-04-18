# UBUNTU

## Installing packages

    apt install i3
    apt install polybar

    apt install htop screen sudo git git-lfs ripgrep zsh pavucontrol
    apt install arandr autorandr xss-lock scrot nitrogen compton brightnessctl rofi
    
    <!-- barrier -->
    
    <!-- neovim (nightly) -->
    
    <!-- obsidian -->

### install symbol only font
    https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/NerdFontsSymbolsOnly
    copy to ~/.local/share/fonts/TTF/
    fc-cache -fv

### neovim

https://github.com/neovim/neovim/blob/master/INSTALL.md#pre-built-archives-2

### kanata

download kanata
https://github.com/jtroo/kanata/releases

create /lib/systemd/system/kanata.service

```
[Unit]
Description=Kanata key remapping daemon
Requires=local-fs.target
After=local-fs.target

[Service]
Type=simple
ExecStart=/usr/bin/kanata --cfg /etc/kanata/kanata.kbd --port 5829

[Install]
WantedBy=sysinit.target
```

mkdir /etc/kanata/
cp dotfiles/kanata.kbd /etc/kanata/

systemctl enable kanata.service
systemctl start kanata.service




### Plantuml
sudo apt install plantuml
for neovim preview
sudo apt install imv
symlink so neovim plugin can find the binary
/usr/bin: sudo ln -s imv-x11 imv

download https://github.com/plantuml/plantuml/releases/download/v1.2024.7/plantuml-1.2024.7.jar
copy to /usr/share/plantuml/plantuml-latest.jar

copy plantuml.config to /usr/share/plantuml/plantuml.config


edit:i /usr/bin/plantuml
# $JAVA -Djava.net.useSystemProxies=true $HEADLESS -jar /usr/share/plantuml/plantuml.jar "$@"
# this one if we set a config
$JAVA -Djava.net.useSystemProxies=true $HEADLESS -jar /usr/share/plantuml/plantuml-latest.jar -config /usr/share/plantuml/plantuml.config "$@"
# if we don't want a config
$JAVA -Djava.net.useSystemProxies=true $HEADLESS -jar /usr/share/plantuml/plantuml-latest.jar "$@"



