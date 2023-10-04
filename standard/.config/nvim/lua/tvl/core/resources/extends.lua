return {
  { "unblevable/quick-scope" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "skywind3000/asyncrun.vim" },
  { "tpope/vim-sleuth" },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        },
      })
    end,
  },

  {
    "ThePrimeagen/harpoon",
    opts = {
      global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = true,
        tmux_autoclose_windows = true,
        excluded_filetypes = { "harpoon", "dashboard", "fugitive" },
        mark_branch = false,
      },
    },
    config = true,
    keys = {
      {
        "ga",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Harpoon add",
      },
      {
        "gm",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon menu",
      },
      {
        "gj",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Harpoon file 1",
      },
      {
        "gk",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Harpoon file 2",
      },
      {
        "gl",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Harpoon file 3",
      },
      {
        "g;",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc = "Harpoon file 4",
      },
      {
        "gt",
        function()
          require("harpoon.tmux").gotoTerminal(1)
        end,
        desc = "Terminal 1",
      },
      {
        "gy",
        function()
          require("harpoon.tmux").gotoTerminal(2)
        end,
        desc = "Terminal 2",
      },
      {
        "<leader><space>m",
        function()
          require("harpoon.cmd-ui").toggle_quick_menu()
        end,
        desc = "Harpoon command menu",
      },
      {
        "<leader><space>j",
        function()
          require("harpoon.tmux").sendCommand(1, 1)
        end,
        desc = "Send Command 1",
      },
      {
        "<leader><space>k",
        function()
          require("harpoon.tmux").sendCommand(1, 2)
        end,
        desc = "Send Command 2",
      },
      {
        "<leader><space>l",
        function()
          require("harpoon.tmux").sendCommand(2, 3)
        end,
        desc = "Send Command 3",
      },
      {
        "<leader><space>;",
        function()
          require("harpoon.tmux").sendCommand(2, 4)
        end,
        desc = "Send Command 4",
      },
    },
  },

  {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
      {
        "<leader>lR",
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
      require("telescope").load_extension("refactoring")
    end,
  },

  {
    "Bekaboo/deadcolumn.nvim",
    config = function()
      require("deadcolumn").setup({
        scope = "line",
        modes = { "i", "ic", "ix", "R", "Rc", "Rx", "Rv", "Rvc", "Rvx" },
        blending = {
          threshold = 0.50,
          colorcode = "#ea6962",
          hlgroup = {
            "Normal",
            "background",
          },
        },
        warning = {
          alpha = 0.4,
          offset = 0,
          colorcode = "#ea6962",
          hlgroup = {
            "Error",
            "background",
          },
        },
        extra = {
          follow_tw = nil,
        },
      })
    end,
  },
  {
    "imNel/monorepo.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope").extensions.monorepo.monorepo()
        end,
        { silent = true, expr = false },
      },
      {
        "<leader>pa",
        function()
          require("monorepo").toggle_project()
        end,
        { silent = true, expr = false },
      },
    },
    config = function()
      require("monorepo").setup({
        {
          silent = false, -- Supresses vim.notify messages
          autoload_telescope = true, -- Automatically loads the telescope extension at setup
          data_path = vim.fn.stdpath("data"), -- Path that monorepo.json gets saved to
        },
      })
      require("telescope").load_extension("monorepo")
    end,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
