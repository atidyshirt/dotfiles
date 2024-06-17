return {
  {
    "folke/noice.nvim",
    enabled = vim.g.nerd_font_enabled,
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline",
        format = {
          cmdline = { icon = "  " },
          search_down = { icon = "  󰄼" },
          search_up = { icon = "  " },
          lua = { icon = "  " },
          async_job = { pattern = "^:%s*AsyncRunWithNotify ", icon = "  " },
        },
      },
      lsp = {
        progress = { enabled = false },
        hover = { enabled = false, silent = true },
        signature = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      messages = {
        enabled = false,
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            find = "%d+L, %d+B",
          },
        },
        {
          filter = {
            find = "No information available",
          },
          opts = { skip = true },
        },
      },
    },
  },
}
