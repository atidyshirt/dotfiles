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

local function scheme_for_appearance(appearance)
   if appearance:find 'Dark' then
      return {
         color_scheme = 'Gruvbox dark, medium (base16)',
         window_decorations = "RESIZE",
         show_new_tab_button_in_tab_bar = false,
         show_tabs_in_tab_bar = false,
         hide_tab_bar_if_only_one_tab = true
      }
   else
      -- No light mode for the moment, there are bugs
      return {
         color_scheme = 'Gruvbox dark, medium (base16)',
         window_decorations = "RESIZE",
         show_new_tab_button_in_tab_bar = false,
         show_tabs_in_tab_bar = false,
         hide_tab_bar_if_only_one_tab = true
      }
      -- return {
      --    color_scheme = 'Catppuccin Latte',
      --    window_decorations = "RESIZE",
      --    show_new_tab_button_in_tab_bar = false,
      --    show_tabs_in_tab_bar = false,
      --    hide_tab_bar_if_only_one_tab = true
      -- }
   end
end

return scheme_for_appearance(get_appearance());
