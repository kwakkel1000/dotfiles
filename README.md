# UBUNTU

## Installing packages

    apt install i3
    apt install polybar

    apt install htop screen sudo git git-lfs ripgrep zsh pavucontrol
    apt install arandr autorandr xss-lock scrot nitrogen compton brightnessctl rofi
    
    barrier
    
    neovim (nightly)
    
    obsidian

### install symbol only font
    https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/NerdFontsSymbolsOnly
    copy to ~/.local/share/fonts/TTF/
    fc-cache -fv

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
