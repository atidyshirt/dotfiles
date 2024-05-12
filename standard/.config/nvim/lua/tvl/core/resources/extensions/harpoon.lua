return {
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
}
