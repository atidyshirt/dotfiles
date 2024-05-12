return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          importModuleSpecifierPreference = 'project-relative'
        }
      }
    },
  },

  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

  {
    'dmmulroy/tsc.nvim',
    config = function ()
      require('tsc').setup()
    end
  },

}
