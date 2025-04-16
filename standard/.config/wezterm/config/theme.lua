local os = require 'os'
local wezterm = require 'wezterm'

local tmux = {
   dark_theme = 'gruvbox-theme.conf',
   light_theme = 'catppuccin-theme.conf'
}

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
   if wezterm.gui then
      return wezterm.gui.get_appearance()
   end
   return 'Dark'
end

local function update_tmux_theme(scheme)
   local command = '';
   local home = os.getenv("HOME")
   local file_path = home .. "/.tmux.conf"
   if scheme == 'dark' then
      command = table.concat({
         "sed",
         "-i",
         "''",
         "s/" .. tmux.light_theme .. "/" .. tmux.dark_theme .. "/g",
         file_path,
      }, " ");
   else if scheme == 'light' then
         command = table.concat({
            "sed",
            "-i",
            "''",
            "s/" .. tmux.dark_theme .. "/" .. tmux.light_theme .. "/g",
            file_path,
         }, " ");
      end
   end
   os.execute(command);
   local reload_command = "tmux source-file " .. file_path
   os.execute(reload_command)
end

local function scheme_for_appearance(appearance)
   if appearance:find 'Dark' then
      update_tmux_theme('dark')
      return {
         color_scheme = 'Gruvbox dark, medium (base16)',
         window_decorations = "RESIZE",
         show_new_tab_button_in_tab_bar = false,
         show_tabs_in_tab_bar = false,
         hide_tab_bar_if_only_one_tab = true
      }
   else
      update_tmux_theme('light')
      return {
         color_scheme = 'Catppuccin Latte',
         window_decorations = "RESIZE",
         show_new_tab_button_in_tab_bar = false,
         show_tabs_in_tab_bar = false,
         hide_tab_bar_if_only_one_tab = true
      }
   end
end

return scheme_for_appearance(get_appearance());
