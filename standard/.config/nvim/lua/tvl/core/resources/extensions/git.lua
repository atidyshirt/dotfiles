local Util = require("tvl.util")
local Icons = require("tvl.core.icons")

return {
  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = Icons.gitsigns.add },
        change = { text = Icons.gitsigns.change },
        delete = { text = Icons.gitsigns.delete },
        topdelhfe = { text = Icons.gitsigns.topdelhfe },
        changedelete = { text = Icons.gitsigns.changedelete },
        untracked = { text = Icons.gitsigns.untracked },
      },
      current_line_blame = false,
      current_line_blame_opts = {
        delay = 300,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      preview_config = {
        border = Util.generate_borderchars("thick", "tl-t-tr-r-bl-b-br-l"),
      },
    },
    keys = {
      { "<leader>hs", ":Gitsigns stage_hunk<CR>" },
      { "<leader>hu", ":Gitsigns undo_stage_hunk<CR>" },
      { "<leader>hS", ":Gitsigns stage_buffer<CR>" },
      { "<leader>hd", ":Gitsigns diffthis<CR>" },
      {
        "<leader>hD",
        function()
          require("gitsigns").diffthis("~")
        end,
      },
    },
  },
}
