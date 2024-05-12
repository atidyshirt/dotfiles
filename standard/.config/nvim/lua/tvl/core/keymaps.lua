local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

function toggle_quickfix()
  if not vim.tbl_isempty(vim.fn.getwininfo()) and vim.bo.buftype == "quickfix" then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end

keymap("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft<CR>", opts)
keymap("n", "<C-l>", "<cmd>NvimTmuxNavigateRight<CR>", opts)
keymap("n", "<C-k>", "<cmd>NvimTmuxNavigateUp<CR>", opts)
keymap("n", "<C-j>", "<cmd>NvimTmuxNavigateDown<CR>", opts)
keymap("n", "gs", ":0G<CR>", opts)
keymap("n", "<leader>x", ":bd!<CR>", opts)
keymap("n", "<leader>X", ":%bd!|e#<CR>", opts)
keymap("n", "<esc>", "<cmd>noh<cr><esc>", opts)
keymap("n", "<leader>q", ":lua toggle_quickfix()<CR>", { silent = true })
vim.keymap.set("n", "<leader>nI", "<cmd>Neorg index<cr>", { desc = "Neorg index" })
vim.keymap.set("n", "<leader>nt", "<cmd>Neorg journal today<cr>", { desc = "Neorg today" })
vim.keymap.set("n", "<leader>nf", "<cmd>Telescope neorg find_norg_files<cr>", { desc = "Search Note Files" })
vim.keymap.set("n", "<leader>nw", "<cmd>Telescope neorg find_linkable<cr>", { desc = "Search Notes" })
vim.keymap.set("n", "<leader>nl", "<cmd>Telescope neorg insert_link<cr>", { desc = "Tangle file" })
vim.keymap.set("n", "<leader>nr", "<cmd>Neorg toc right<cr>", { desc = "Open ToC (right)" })
vim.keymap.set("n", "<leader>tv", "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<cr>", { desc = "View code block" })
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("n", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

vim.keymap.set("n", "<C-f>", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes"))
end, { desc = "[/] Fuzzily search in current buffer]" })
