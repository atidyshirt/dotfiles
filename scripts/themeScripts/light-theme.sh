osascript -e \
'tell application "system events" to tell appearance preferences to set dark mode to not dark mode'

kitty @ set-colors --all --configured $HOME/.config/kitty/themes/gruvbox-light.conf
echo "include $HOME/.config/kitty/themes/gruvbox-light.conf" > $HOME/.config/kitty/theme.conf
echo "source $HOME/.config/nvim/themes/gruvbox-light.vim" > $HOME/.config/nvim/themes/theme.vim

sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '/Users/atidyshirt/.wallpaper/light-theme.jpeg'";
killall Dock;

# osascript -e 'set desktopImage to POSIX file "/Users/atidyshirt/.wallpaper/light-theme.png"
# tell application "Finder"
    # set desktop picture to desktopImage
# end tell'

osascript -e "tell application id \"tracesOf.Uebersicht\" to refresh"

sudo yabai --load-sa
