return {
  { "unblevable/quick-scope" },
  { "tpope/vim-surround" },
  { "skywind3000/asyncrun.vim" },
  { "tpope/vim-sleuth" },

  {
    'echasnovski/mini.ai',
    version = '*',
    config = true,
  },

  {
    'numToStr/Comment.nvim',
    opts = {
    },
    lazy = false,
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },

  {
    "nvim-tree/nvim-web-devicons",
    enabled = vim.g.nerd_font_enabled,
    lazy = true,
    config = function ()
      require("nvim-web-devicons").setup()
    end
  },

  { "vitalk/vim-shebang" },

  {
    "Wansmer/treesj",
    keys = { { "<leader>lj", "<cmd>TSJToggle<cr>", desc = "Split / Join" } },
    opts = { use_default_keymaps = false },
  },
}
