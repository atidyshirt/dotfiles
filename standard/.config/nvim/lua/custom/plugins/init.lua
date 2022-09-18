local overrides = require "custom.plugins.overrides"

return {

  ["goolord/alpha-nvim"] = {
    disable = false
  }, -- enables dashboard

  -- Override plugin definition options
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  ["kyazdani42/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },

  -- Install a plugin
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- code formatting, linting etc
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  -- utility plugins
  ['unblevable/quick-scope'] = {},
  ['tpope/vim-fugitive'] = {},
  ['tpope/vim-surround'] = {},
  ['christoomey/vim-tmux-navigator'] = {},
  ['weilbith/nvim-code-action-menu'] = {
    cmd = 'CodeActionMenu'
  },

  -- Harpoon
  ['ThePrimeagen/harpoon'] = {},


}
