local M = {}

M.ui = {
  theme_toggle = { "gruvbox_material", "blossom" },
  theme = "gruvbox_material",
}

M.plugins = require "custom.plugins"
M.mappings = require "custom.mappings"

-- setup options
require "custom.options"

return M
