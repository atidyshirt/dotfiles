# Yabai Config

**Initial Setup:**

```sh { tangle: ./mac/.yabairc }
#!/usr/bin/env sh

yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
sudo yabai --load-sa
```

**Colors:**

```sh { tangle: ./mac/.yabairc }
gruvInactive=32302f
gruvActive=62554A
```

### Settings

**global settings:**

```sh { tangle: ./mac/.yabairc }
yabai -m config window_placement             second_child
yabai -m config split_ratio                  0.50
yabai -m config mouse_modifier               fn
yabai -m config mouse_action1                move
yabai -m config mouse_action2                resize
```

**space settings:**

```sh { tangle: ./mac/.yabairc }
yabai -m config layout                       bsp
yabai -m config external_bar                 main:39:0
yabai -m config top_padding                  15
yabai -m config bottom_padding               15
yabai -m config left_padding                 15
yabai -m config right_padding                15
yabai -m config window_gap                   15
```

**window decorations:**

defining window decorations on MacOS windows, we have avalible options such as `boarders`, `opacity`, `blur`, `hidpi`, `animations` and `shadow`.
We can define these options using the following method.

```sh { tangle: ./mac/.yabairc }
yabai -m config window_border                on
yabai -m config window_border_width          4
yabai -m config active_window_border_color   0xff$gruvActive
yabai -m config insert_feedback_color        0xff$gruvActive
yabai -m config normal_window_border_color   0xff$gruvInactive
yabai -m config window_opacity               off
yabai -m config active_window_opacity        0.92
yabai -m config normal_window_opacity        0.92
yabai -m config window_border_blur           off
yabai -m config window_border_hidpi          off
yabai -m config window_shadow                off

yabai -m config window_animation_duration    0.20
```

### Rules

We can define rules for different apps that are enforced by yabai, here are some examples that I use in my current configuration.

```sh { tangle: ./mac/.yabairc }
yabai -m rule --add app=Spotify --space 6
yabai -m rule --add app=Discord --space 6
yabai -m rule --add app="^System Preferences$" manage=off
yabai -m rule --add app=Dashlane manage=off
yabai -m rule --add app=Spotify manage=off
yabai -m rule --add app=Godot manage=off
yabai -m rule --add app=Discord manage=off
yabai -m rule --add app=Übersicht manage=off
yabai -m rule --add app=BetterTouchTool manage=off
```

### Signals

`yabai` can send signals on certain events in yabai. We can use these signals to launch commands to alter other processes. 
Below we are using these to control the `sketchybar` application in order to update the spaces and current window that is displayed
in the menu bar.

For more information on using signals, run `man yabai` and search for `signals` to read the official documentation on how to use them.

```sh { tangle: ./mac/.yabairc }
yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"
```

# Yabai Keybinds (skhd)

Core bindings for opening key applications

```sh { tangle: ./mac/.skhdrc }
cmd - return : /Applications/Kitty.app/Contents/MacOS/kitty --single-instance -d ~ &> /dev/null
alt - return : open -na "/Applications/Google Chrome.app"
alt - m : open -na /Applications/mpv.app $(pbpaste)
```

**window manipulations**

```sh { tangle: ./mac/.skhdrc }
alt - x : yabai -m window --focus recent
alt - h : yabai -m window --focus west
alt - j : yabai -m window --focus south
alt - k : yabai -m window --focus north
alt - l : yabai -m window --focus east

alt - tab         : yabai -m window --focus stack.next
alt + shift - tab : yabai -m window --focus stack.prev

shift + alt - h : yabai -m window --warp west
shift + alt- j : yabai -m window --warp south
shift + alt - k : yabai -m window --warp north
shift + alt - l : yabai -m window --warp east

shift + ctrl - a : yabai -m window --move rel:-60:0
shift + ctrl - s : yabai -m window --move rel:0:60
shift + ctrl - w : yabai -m window --move rel:0:-60
shift + ctrl - d : yabai -m window --move rel:60:0

# increase window size
shift + alt - a : yabai -m window --resize left:-60:0
shift + alt - s : yabai -m window --resize bottom:0:60
shift + alt - w : yabai -m window --resize top:0:-60
shift + alt - d : yabai -m window --resize right:60:0

# decrease window size
shift + cmd - a : yabai -m window --resize left:60:0
shift + cmd - s : yabai -m window --resize bottom:0:-60
shift + cmd - w : yabai -m window --resize top:0:60
shift + cmd - d : yabai -m window --resize right:-60:0

# set insertion point in focused container
shift + cmd - h : yabai -m window --insert west
shift + cmd - j : yabai -m window --insert south
shift + cmd - k : yabai -m window --insert north
shift + cmd - l : yabai -m window --insert east
shift + cmd - i : yabai -m window --insert stack

# Useful for switching window stack for a specific parent/child node pair
alt - e : yabai -m window --toggle split
```

**switching between desktops/spaces**

These are keybindings for switching between spaces/desktops in MacOS, the last three bindings
in this section are used to set specific desktop layouts between `bsp`, `floating` and `stacked`.
These effects can also be used on a per-node basis to allow for nodes to be both stacked and tiled
within the same space!

```sh { tangle: ./mac/.skhdrc }
alt - 1 : yabai -m space --focus  1
alt - 2 : yabai -m space --focus  2
alt - 3 : yabai -m space --focus  3
alt - 4 : yabai -m space --focus  4
alt - 5 : yabai -m space --focus  5
alt - 6 : yabai -m space --focus  6

# send window to desktop and follow focus
shift + cmd - 1 : yabai -m window --space  1; yabai -m space --focus 1
shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2
shift + cmd - 3 : yabai -m window --space  3; yabai -m space --focus 3
shift + cmd - 4 : yabai -m window --space  4; yabai -m space --focus 4
shift + cmd - 5 : yabai -m window --space  5; yabai -m space --focus 5


shift + alt - z : yabai -m space --layout bsp
shift + alt - x : yabai -m space --layout float
shift + alt - c : yabai -m space --layout stack
```

**Focusing connected displays and monitors**

```sh { tangle: ./mac/.skhdrc }
ctrl + alt - 1  : yabai -m display --focus 1
ctrl + alt - 2  : yabai -m display --focus 2
ctrl + alt - 3  : yabai -m display --focus 3

# send window to monitor and follow focus
ctrl + cmd - 1  : yabai -m window --display 1; yabai -m display --focus 1
ctrl + cmd - 2  : yabai -m window --display 2; yabai -m display --focus 2
ctrl + cmd - 3  : yabai -m window --display 3; yabai -m display --focus 3
```

**Zooming over windows**

The following keybinds are for zooming a parent node in the bsp tree, zooming fullscreen within the bounds of Yabai's
tiling and the ability to zoom to native fullscreen using MacOS's native fullscreen mode.

```sh { tangle: ./mac/.skhdrc }
alt - d : yabai -m window --toggle zoom-parent; \
    sketchybar --trigger window_focus

# toggle window fullscreen zoom
alt - f : yabai -m window --toggle zoom-fullscreen; \
    sketchybar --trigger window_focus

# toggle window native fullscreen
shift + alt - f : yabai -m window --toggle native-fullscreen
```

**Toggling floating windows**


```sh { tangle: ./mac/.skhdrc }
alt - t : yabai -m window --toggle float; \
          yabai -m window --grid 4:4:1:1:2:2; \
          sketchybar --trigger window_focus

shift + alt - t : yabai -m window --toggle float;\
          yabai -m window --grid 20:20:1:1:18:18; \
          sketchybar --trigger window_focus
```

**Picture in picture bindings**

```sh { tangle: ./mac/.skhdrc }
alt - p : yabai -m window --toggle sticky;\
    yabai -m window --toggle topmost;\
    yabai -m window --grid 4:4:4:0:1:1

 shift + alt - p : yabai -m window --toggle float; \
```
