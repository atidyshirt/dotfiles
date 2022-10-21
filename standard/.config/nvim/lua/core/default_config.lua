-- Chadrc overrides this file

local M = {}

M.ui = {
  hl_add = {},
  hl_override = {},
  changed_themes = {},
  theme_toggle = { "gruvbox_material", "blossom" },
  theme = "gruvbox_material",
  transparency = false,
}

M.plugins = {}
M.mappings = require "core.mappings"

return M
