sketchybar --default background.border_color=$YELLOW               \
                     icon.color=$YELLOW                            \
                     icon.highlight_color=$BACKGROUND              \
                     icon.padding_left=6                           \
                     icon.padding_right=2                          \
                     label.color=$YELLOW                           \
                     label.highlight_color=$BACKGROUND             \
                     label.padding_left=2                          \
                     label.padding_right=6                         \
                     label.font="SF Pro:Semibold:12.0"

# Spacer
sketchybar --add item spacer right                \
           --set spacer background.drawing=off     \
                         width=10


sketchybar --add item  swap right                        \
           --set       swap script="$PLUGIN_DIR/swap.sh" \
                            update_freq=60               \
                            padding_left=2               \
                            padding_right=8              \
                            background.border_width=0    \
                            background.height=24         \
                            icon=                       \
                            icon.font="FiraCode Nerd Font:20.0" \
                            icon.color=$BLUE             \
                            label.color=$BLUE            \
                                                         \
           --add item  ram right                         \
           --set       ram script="$PLUGIN_DIR/ram.sh"   \
                           update_freq=60                \
                           padding_left=2                \
                           padding_right=2               \
                           background.border_width=0     \
                           background.height=24          \
                           icon=                        \
                           icon.font="FiraCode Nerd Font:20.0" \
                           icon.color=$GREEN             \
                           label.color=$GREEN            \
                                                         \
           --add item  disk right                        \
           --set       disk script="$PLUGIN_DIR/disk.sh" \
                            update_freq=60               \
                            padding_left=2               \
                            padding_right=2              \
                            background.border_width=0    \
                            background.height=24         \
                            icon=                       \
                            icon.font="FiraCode Nerd Font:20.0" \
                            icon.color=$YELLOW           \
                            label.color=$YELLOW          \
                                                         \
           --add item  cpu right                         \
           --set       cpu script="$PLUGIN_DIR/cpu.sh"  \
                           update_freq=60                \
                           padding_left=8                \
                           padding_right=2               \
                           background.border_width=0     \
                           background.height=24          \
                           icon=                        \
                           icon.font="FiraCode Nerd Font:20.0" \
                           icon.color=$RED               \
                           label.color=$RED

# Bracket
sketchybar --add bracket activity swap ram disk cpu                \
           --set         activity background.color=$BACKGROUND     \
                                  background.border_color=$BAR_BORDER_COLOR
