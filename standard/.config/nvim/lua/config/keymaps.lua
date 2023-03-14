------------------------ GENERAL -----------------------------
vim.keymap.set("n", "U", "<c-r>")

vim.keymap.set("n", "<ESC>", "<cmd> noh <CR>")
vim.keymap.set("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>NvimTmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>NvimTmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>NvimTmuxNavigateDown<CR>")

vim.keymap.set("n", "gs", ":0G<CR>")

vim.keymap.set("n", "<leader>x", ":bd!<CR>")
vim.keymap.set("n", "<leader>X", ":%bd!|e#<CR>")

------------------------ MARKDOWN ----------------------------
vim.keymap.set("n", "<leader>tp", ":!pandoc % -o %<.pdf --template eisvogel --listings")

------------------------ COMMENTS ----------------------------
vim.keymap.set("n", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>")
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

------------------------- LSP --------------------------------
vim.keymap.set("n", "lf", "<cmd>TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "lw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
vim.keymap.set("n", "lt", "<cmd>TodoTrouble<cr>")
