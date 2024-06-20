local Icon = require("tvl.core.icons")

return {
  {
    "utilyre/barbecue.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      {
        "nvim-tree/nvim-web-devicons",
        enabled = vim.g.nerd_font_enabled
      },
    },
    opts = {
      attach_navic = false,
      theme = "auto",
      include_buftypes = { "" },
      exclude_filetypes = { "gitcommit", "Trouble", "toggleterm" },
      show_modified = false,
      symbols = Icon.bbq_symbols,
      kinds = Icon.kinds,
    },
  },
}
