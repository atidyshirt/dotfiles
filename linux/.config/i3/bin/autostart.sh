#!/usr/bin/env bash

_ps=(picom dunst ksuperkey mpd xfce-polkit xfce4-power-manager)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

xsetroot -cursor_name left_ptr
/usr/lib/xfce-polkit/xfce-polkit &
xfce4-power-manager &
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &
~/.config/i3/bin/i3dunst.sh
~/.config/i3/bin/i3comp.sh
