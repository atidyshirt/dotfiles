local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 0,
  confirm = true,
  completeopt = { "menu", "menuone", "noselect" },
  conceallevel = 0,
  fileencoding = "utf-8",
  incsearch = true,
  hlsearch = true,
  inccommand = "nosplit",
  ignorecase = true,
  grepformat = "%f:%l:%c:%m",
  grepprg = "rg --vimgrep",
  mouse = "a",
  pumheight = 10,
  showmode = false,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 400,
  undofile = true,
  updatetime = 500,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = true,
  numberwidth = 4,
  signcolumn = "yes",
  wrap = false,
  laststatus = 3,
  background = "dark",
  selection = "exclusive",
  virtualedit = "onemore",
  showcmd = false,
  title = true,
  titlestring = "%<%F%=%l/%L - nvim",
  linespace = 8,
  mousemoveevent = true,
  syntax = "off",
  spelllang = { "en" },
  colorcolumn = "120",

  foldlevelstart = 99,
  foldlevel = 99,
  foldenable = true,
  foldcolumn = "1",
  fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
  },

  sessionoptions = { "buffers", "curdir", "tabpages", "winsize" },
}
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.shortmess:append("c")
vim.opt.viewoptions:remove "curdir"

vim.opt.list = true

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,]")
vim.cmd([[set iskeyword+=-]])

vim.cmd([[set foldopen-=hor]])

if vim.g.neovide then
  vim.opt.guifont = "Cascadia Code:h10"
  vim.g.neovide_scale_factor = 1
end


vim.g.asyncrun_silent = 0
