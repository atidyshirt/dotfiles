local opt = vim.opt

opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.title = true
opt.titlestring = "%t - Vim" -- Set title string
opt.clipboard = "unnamedplus"
opt.cursorline = true

-- GUI font settings
vim.opt.guifont = { "FiraCode Nerd Font", ":h16" }

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.errorbells = false

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

opt.updatetime = 250
opt.timeoutlen = 400

-- cursorcolumn
opt.colorcolumn = "120"

-- Folding (from nvim-ufo)
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Jumplist (from portal.nvim)
vim.opt.jumpoptions = "stack"

-- Disable comment continuation
vim.opt.formatoptions:remove("o")
