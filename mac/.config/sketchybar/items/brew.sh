#!/usr/bin/env sh

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add event brew_update                           \
           --add item brew right                             \
           --set brew script="$PLUGIN_DIR/brew.sh"           \
                      icon=􀐛                                 \
                      label=?                                \
                      background.padding_right=15            \
                      click_script="$POPUP_CLICK_SCRIPT"     \
           --subscribe brew     brew_update                  \
          --add       item      brew.template left popup.brew \
