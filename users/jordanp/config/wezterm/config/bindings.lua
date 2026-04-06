local wezterm = require('wezterm')
local platform = require('utilities.platform')()
local action = wezterm.action

local mod = {}

mod.CONTROL = 'CTRL'
mod.CONTROL_SHIFT = 'CTRL|SHIFT'

if platform.is_mac then
   mod.SUPER = 'SUPER'
   mod.SUPER_REV = 'SUPER|CTRL'
   mod.COMMAND_OR_CONTROL = 'SUPER'
elseif platform.is_win or platform.is_linux then
   mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
   mod.SUPER_REV = 'ALT|CTRL'
   mod.COMMAND_OR_CONTROL = 'CTRL'
end

local keys = {
   { key = 'f', mods = mod.SUPER, action = action.Search({ CaseInSensitiveString = '' }) },
   { key = 'w', mods = mod.SUPER, action = action.CloseCurrentTab { confirm = false }, },
   { key = 'q', mods = mod.SUPER, action = action.QuitApplication },

   { key = 'c', mods = mod.CONTROL_SHIFT, action = action.CopyTo('Clipboard') },
   { key = 'v', mods = mod.CONTROL_SHIFT, action = action.PasteFrom('Clipboard') },
}

local mouse_bindings = {
   -- Ctrl-click will open the link under the mouse cursor
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = mod.COMMAND_OR_CONTROL,
      action = action.OpenLinkAtMouseCursor,
   },
   -- Move mouse will only select text and not copy text to clipboard
   {
      event = { Down = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = action.SelectTextAtMouseCursor('Cell'),
   },
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = action.ExtendSelectionToMouseCursor('Cell'),
   },
   {
      event = { Drag = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = action.ExtendSelectionToMouseCursor('Cell'),
   },
   -- Triple Left click will select a line
   {
      event = { Down = { streak = 3, button = 'Left' } },
      mods = 'NONE',
      action = action.SelectTextAtMouseCursor('Line'),
   },
   {
      event = { Up = { streak = 3, button = 'Left' } },
      mods = 'NONE',
      action = action.SelectTextAtMouseCursor('Line'),
   },
   -- Double Left click will select a word
   {
      event = { Down = { streak = 2, button = 'Left' } },
      mods = 'NONE',
      action = action.SelectTextAtMouseCursor('Word'),
   },
   {
      event = { Up = { streak = 2, button = 'Left' } },
      mods = 'NONE',
      action = action.SelectTextAtMouseCursor('Word'),
   },
   -- Turn on the mouse wheel to scroll the screen
   {
      event = { Down = { streak = 1, button = { WheelUp = 1 } } },
      mods = 'NONE',
      action = action.ScrollByCurrentEventWheelDelta,
   },
   {
      event = { Down = { streak = 1, button = { WheelDown = 1 } } },
      mods = 'NONE',
      action = action.ScrollByCurrentEventWheelDelta,
   },
}

return {
   disable_default_key_bindings = true,
   disable_default_mouse_bindings = true,
   leader = { key = 'Space', mods = 'CTRL|SHIFT' },
   key_tables = {
      copy_mode = wezterm.gui.default_key_tables().copy_mode,
   },
   keys = keys,
   mouse_bindings = mouse_bindings,
}
