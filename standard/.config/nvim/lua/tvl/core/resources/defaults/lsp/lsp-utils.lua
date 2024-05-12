return {
  {
    "ray-x/lsp_signature.nvim",
    event = { "InsertEnter" },
    opts = {
      floating_window = false,
      floating_window_above_cur_line = true,
      hint_scheme = "Comment",
    },
  },

  {
    "glepnir/lspsaga.nvim",
    lazy = true,
    config = function()
      require("lspsaga").setup({})
    end,
  },

  { "folke/neodev.nvim", opts = {} }
}
