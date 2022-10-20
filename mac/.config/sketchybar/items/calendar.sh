#!/usr/bin/env sh

sketchybar --add item     calendar right               \
           --set calendar update_freq=15               \
                          icon=cal                     \
                          icon.color=$BLACK            \
                          icon.font="$FONT:Black:12.0" \
                          icon.padding_left=5         \
                          icon.padding_right=5         \
                          label.color=$BLACK           \
                          label.padding_left=5        \
                          label.padding_right=5       \
                          width=140                    \
                          align=center                 \
                          script="$PLUGIN_DIR/time.sh" \
                          background.color=0xff62554A  \
                          background.height=26         \
                          background.corner_radius=11
