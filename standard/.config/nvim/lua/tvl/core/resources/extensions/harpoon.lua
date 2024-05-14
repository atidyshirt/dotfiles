return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "harpoon2",
    config = function ()
      local harpoon = require("harpoon");
      local tmux = require("tvl.core.resources.extensions.harpoon-tmux.tmux");

      harpoon:setup({
        ["tmux"] = {
          select = function(list_item)
            tmux.send_command(1, list_item.value)
          end
        }
      })

      vim.keymap.set("n", "ga", function() harpoon:list():add() end)
      vim.keymap.set("n", "gm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "gj", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "gk", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "gl", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "g;", function() harpoon:list():select(4) end)

      vim.keymap.set("n", "gt", function() tmux.go_to_terminal(1) end)
      vim.keymap.set("n", "gy", function() tmux.go_to_terminal(2) end)

      vim.keymap.set("n", "<leader><space>m", function() harpoon.ui:toggle_quick_menu(harpoon:list('tmux')) end)
      vim.keymap.set("n", "<leader><space>j", function() harpoon:list('tmux'):select(1) end)
      vim.keymap.set("n", "<leader><space>k", function() harpoon:list('tmux'):select(2) end)
      vim.keymap.set("n", "<leader><space>l", function() harpoon:list('tmux'):select(3) end)
      vim.keymap.set("n", "<leader><space>;", function() harpoon:list('tmux'):select(4) end)
    end,
  },
}
