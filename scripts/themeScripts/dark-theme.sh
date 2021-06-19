osascript -e \
'tell application "system events" to tell appearance preferences to set dark mode to not dark mode'

kitty @ set-colors --all --configured $HOME/.config/kitty/themes/gruvbox.conf
echo "include $HOME/.config/kitty/themes/gruvbox.conf" > $HOME/.config/kitty/theme.conf
echo "source $HOME/.config/nvim/themes/gruvbox.vim" > $HOME/.config/nvim/themes/theme.vim

sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '/Users/atidyshirt/.wallpaper/gruvbox-lines.jpeg'";
killall Dock;

osascript -e "tell application id \"tracesOf.Uebersicht\" to refresh"

sudo yabai --load-sa
