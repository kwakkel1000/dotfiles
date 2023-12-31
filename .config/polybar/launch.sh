#!/bin/bash

killall -q polybar
#polybar-msg cmd quit

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar -c $HOME/.config/polybar/config.ini --reload example &
    done
else
    polybar --reload example &
fi
