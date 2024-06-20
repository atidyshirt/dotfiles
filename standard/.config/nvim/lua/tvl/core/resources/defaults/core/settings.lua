local util = require("tvl.util")

vim.g.nerd_font_enabled = true
vim.g.luarocks_enabled = true

-- autocmds and keymaps can wait to load
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    util.load("autocmds")
    util.load("keymaps")
  end,
})

util.load("options")

return {}
