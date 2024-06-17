local config = require("tvl.config.lualine.config")

local M = {}

local function setup()
  local cpn = require("tvl.config.lualine.components")
  local theme = require("tvl.config.lualine.highlights").custom(config.options)

  require("lualine").setup({
    options = {
      theme = theme,
      icons_enabled = vim.g.nerd_font_enabled,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "dashboard", "lazy", "alpha" },
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
      },
    },
    sections = {
      lualine_a = { cpn.branch },
      lualine_b = { cpn.diagnostics },
      lualine_c = { cpn.diff },
      lualine_x = {},
      lualine_y = { cpn.position },
      lualine_z = { cpn.mode },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {},
  })
end

M.setup = config.setup

M.load = function()
  setup()
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      setup()
    end,
  })
end

return M
