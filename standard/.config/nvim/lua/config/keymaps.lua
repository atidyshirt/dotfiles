------------------------ GENERAL -----------------------------
vim.keymap.set("n", "U", "<c-r>")

vim.keymap.set("n", "<ESC>", "<cmd> noh <CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

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
