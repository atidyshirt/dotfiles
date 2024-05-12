return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      float = true,
      separator = "square",
      ---@type any
      colorful = true,
    },
    config = function(_, opts)
      local lualine_config = require("tvl.config.lualine")
      lualine_config.setup(opts)
      lualine_config.load()
    end,
  },
}
