# Yabai Config

**Initial Setup:**

Firstly we initilise the `yabai` file with a shebang and load the scripting extension and restart the dock process.

```sh { tangle: ./mac/.yabairc }
#!/usr/bin/env sh

yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
sudo yabai --load-sa
```

**Colors:**

We then define some colors that are used as the accent and border colors.

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
