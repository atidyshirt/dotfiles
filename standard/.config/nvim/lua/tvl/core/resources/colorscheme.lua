-- disable git detecting changes
-- git update-index --skip-worktree lua/tvl/core/resources/colorscheme.lua

-- enable git detecting changes
-- git update-index --no-skip-worktree lua/tvl/core/resources/colorscheme.lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },

  {
    "sainnhe/gruvbox-material",
    lazy = true,
  },

  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local monokai = require("monokai-pro")
      monokai.setup({
        transparent_background = false,
        devicons = true,
        filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
        day_night = {
          enable = false,
          day_filter = "pro",
          night_filter = "spectrum",
        },
        inc_search = "background", -- underline | background
        background_clear = { "nvim-tree", "neo-tree", "bufferline" },
        plugins = {
          bufferline = {
            underline_selected = true,
            underline_visible = false,
            underline_fill = true,
            bold = false,
          },
          indent_blankline = {
            context_highlight = "pro", -- default | pro
            context_start_underline = true,
          },
        },
        override = function(c)
          return {
            ColorColumn = { bg = c.editor.background },
            DashboardRecent = { fg = c.base.magenta },
            DashboardProject = { fg = c.base.blue },
            DashboardConfiguration = { fg = c.base.white },
            DashboardSession = { fg = c.base.green },
            DashboardLazy = { fg = c.base.cyan },
            DashboardServer = { fg = c.base.yellow },
            DashboardQuit = { fg = c.base.red },
            CmpItemKindVariable = { fg = "#09B6A2" },
          }
        end,
      })
      monokai.load()
    end,
  },
}
