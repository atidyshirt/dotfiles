#!/usr/bin/env sh

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add item clipboard right                        \
           --set clipboard script="python3 $PLUGIN_DIR/clipboard.py" \
                      updates=on                             \
                      update_freq=30                    \
                      icon=                              \
                      background.padding_right=15            \
                      click_script="python3 $PLUGIN_DIR/clipboard.py && $POPUP_CLICK_SCRIPT" \
                      icon.font="$FONT:Regular:18.0"       \
           --add item clipboard.template left popup.clipboard \
