#!/usr/bin/env bash

if [[ ! `pidof polybar` ]]; then
    polybar -q main -c $HOME/.config/i3/polybar/config
else
    polybar-msg cmd restart
fi
