-- Require the sketchybar module
sbar = require("sketchybar")

-- Register sketchybar-app-font with CoreText for *this* process (DOMAIN_ADD_FONT / --load-font).
-- User fonts in ~/Library/Fonts are not always visible to GUI subprocesses until registered;
-- without this, label text stays literal ":wezterm:" instead of icons.
do
  local home = os.getenv("HOME") or ""
  local bin = os.getenv("SKETCHYBAR_BIN") or "sketchybar"
  local font = home .. "/Library/Fonts/sketchybar-app-font.ttf"
  os.execute(string.format("'%s' --load-font '%s' 2>/dev/null", bin:gsub("'", "'\\''"), font:gsub("'", "'\\''")))
end
sbar.begin_config()
require("bar")
require("default")
require("items")
sbar.end_config()

sbar.event_loop()
