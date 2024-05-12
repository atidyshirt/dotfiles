return {
  {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
      {
        "<leader>lf",
        function()
          require("refactoring").select_refactor()
        end,
        { silent = true, expr = false },
        desc = "Refactoring",
      },
      {
        "<leader>pf",
        function()
          require("refactoring").debug.printf({ below = false })
        end,
        mode = { "n" },
        desc = "Debug: Print Function",
      },
      {
        "<leader>pv",
        function()
          require("refactoring").debug.print_var({ normal = true, below = false })
        end,
        mode = { "n" },
        desc = "Debug: Print Variable",
      },
      {
        "<leader>pv",
        function()
          require("refactoring").debug.print_var({ below = false })
        end,
        mode = { "v" },
        desc = "Debug: Print Variable",
      },
      {
        "<leader>pc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        mode = { "n" },
        desc = "Debug: Clean Up",
      },
    },
    config = function()
      require("refactoring").setup({})
      require("lua.tvl.core.resources.defaults.core.telescope").load_extension("refactoring")
    end,
  },
}
