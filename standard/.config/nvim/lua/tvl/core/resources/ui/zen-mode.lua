return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = function()
          return math.min(120, vim.o.columns * 0.75)
        end,
      },
      options = {
        number = false,
        relativenumber = false,
        foldcolumn = "0",
        list = false,
        showbreak = "NONE",
        signcolumn = "no",
      },
      plugins = {
        options = {
          cmdheight = 1,
          laststatus = 0,
        },
      },
    }
  },
}
