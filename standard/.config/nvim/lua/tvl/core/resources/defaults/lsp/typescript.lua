return {
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {
  --     settings = {
  --       tsserver_file_preferences = {
  --         importModuleSpecifierPreference = 'project-relative'
  --       }
  --     }
  --   },
  -- },

  {
    "yioneko/nvim-vtsls",
    opts = {
      settings = {
        tsserver_file_preferences = {
          importModuleSpecifierPreference = 'project-relative'
        }
      }
    },
    config = function(_, opts)
      require("vtsls").config(opts)
    end,
  },

  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

  {
    'dmmulroy/tsc.nvim',
    config = function ()
      require('tsc').setup()
    end
  },

}
