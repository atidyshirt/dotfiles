#!/bin/sh

FONT="Liga SFMono Nerd Font" # Needs to have Regular, Bold, Semibold, Heavy and Black variants

sketchybar -m --add item battery right \
  --set battery update_freq=30 \
  script="$PLUGIN_DIR/power.sh" \
  icon.font="$FONT:Bold:14.0"                       \
  icon.color=$ICON_COLOR                            \
  label.font="$FONT:Semibold:13.0"                  \
