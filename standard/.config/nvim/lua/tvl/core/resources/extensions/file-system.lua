return {
  {
    'stevearc/oil.nvim',
    opts = {
      columns = {
        'mtime',
        'permissions',
        'size',
        'icon',
      },
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<esc>"] = "actions.close",
        ["q"] = "actions.close",
      },
    },
    keys = {
      { "<leader>e", ":Oil<cr>", desc = "Explorer (Oil)", remap = true },
    },
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        enabled = vim.g.nerd_font_enabled
      },
    },
  },
}
