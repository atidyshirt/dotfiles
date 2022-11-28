#!/bin/sh

FONT="FiraCode Nerd Font" # Needs to have Regular, Bold, Semibold, Heavy and Black variants

sketchybar -m --add item battery right \
  --set battery update_freq=3 \
  script="$PLUGIN_DIR/power.sh" \
  icon= \
  icon.font="$FONT:Bold:14.0"                       \
  icon.color=$ICON_COLOR                            \
  label.font="$FONT:Semibold:13.0"                  \
