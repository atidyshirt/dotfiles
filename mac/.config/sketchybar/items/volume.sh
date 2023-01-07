#!/usr/bin/env sh

sketchybar --add item volume right                      \
           --set volume script="$PLUGIN_DIR/volume.sh"  \
                        updates=on                      \
                        icon.background.drawing=on      \
                        icon.background.color=$GREY   \
                        icon.background.height=8        \
                        icon.background.corner_radius=3 \
                        icon.width=0                    \
                        icon.align=right                \
                        label.drawing=off               \
                        background.drawing=on           \
                        background.color=$BAR_COLOR  \
                        background.height=8             \
                        background.corner_radius=3      \
                        background.padding_left=0       \
                        background.padding_right=0      \
                        align=left                      \
           --subscribe volume volume_change

sketchybar --add alias "Control Centre,Sound" right                      \
           --rename "Control Centre,Sound" volume_alias                  \
           --set volume_alias icon.drawing=off                           \
                              label.drawing=off                          \
                              alias.color=$GREY                        \
                              background.padding_right=0                 \
                              background.padding_left=-5                 \
                              width=50                                   \
                              align=right                                \
                              click_script="$PLUGIN_DIR/volume_click.sh"
