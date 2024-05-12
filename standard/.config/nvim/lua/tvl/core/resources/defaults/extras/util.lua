return {
  { "unblevable/quick-scope" },
  { "tpope/vim-surround" },
  { "skywind3000/asyncrun.vim" },
  { "tpope/vim-sleuth" },

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
    lazy = true,
  },

  { "vitalk/vim-shebang" },

  {
    "Wansmer/treesj",
    keys = { { "<leader>lj", "<cmd>TSJToggle<cr>", desc = "Split / Join" } },
    opts = { use_default_keymaps = false },
  },
}
