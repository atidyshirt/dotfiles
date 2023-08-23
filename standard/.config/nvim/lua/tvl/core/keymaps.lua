local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

------------------------ GENERAL -----------------------------
keymap("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft<CR>", opts)
keymap("n", "<C-l>", "<cmd>NvimTmuxNavigateRight<CR>", opts)
keymap("n", "<C-k>", "<cmd>NvimTmuxNavigateUp<CR>", opts)
keymap("n", "<C-j>", "<cmd>NvimTmuxNavigateDown<CR>", opts)
keymap("n", "gs", ":0G<CR>", opts)

keymap("n", "<leader>x", ":bd!<CR>", opts)
keymap("n", "<leader>X", ":%bd!|e#<CR>", opts)

-- Clear search with <esc>
keymap("n", "<esc>", "<cmd>noh<cr><esc>", opts)

-- Quickfix/tasks
vim.cmd([[ command! -nargs=* AsyncRunWithNotify :AsyncRun -post=echom\ 'async-task:\ '\ .\ g:asyncrun_status <args> ]])
function ToggleQFix()
  if not vim.tbl_isempty(vim.fn.getwininfo()) and vim.bo.buftype == "quickfix" then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end
keymap("n", "<leader>c", ":AsyncRunWithNotify ", opts)
keymap("n", "<leader>q", ":lua ToggleQFix()<CR>", { silent = true })

------------------------ MARKDOWN ----------------------------
keymap("n", "<leader>tp", ":!pandoc % -o %<.pdf --template eisvogel --listings", opts)

-------------------- Stay in indent mode ------------------------
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

------------------------ COMMENTS ----------------------------
keymap("n", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-------------------- Fuzzy Search --------------------------------
vim.keymap.set("n", "<C-f>", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes"))
end, { desc = "[/] Fuzzily search in current buffer]" })
