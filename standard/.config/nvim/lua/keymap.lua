-- {{{
local function map(mode, bind, exec, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

local function unmap(mode, bind) vim.api.nvim_del_keymap(mode, bind) end

local opt = {} -- empty opt for maps with no extra options
local M = {}
-- }}}

-- {{{ generic leader bindings
vim.g.mapleader = ' ' -- Map leader key to space
vim.g.maplocalleader = ','
map('', '<leader>e', ':Ex | :setlocal nobuflisted<CR>', opt) -- toggle nvimtree
map('', '<leader>/', ':CommentToggle<CR>', opt) -- toggle comment on current line or selection

-- {{{ autocompletion mappings for cmp 
local cmp = require('cmp')
M.cmp_mappings = {
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
    ['<C-l>'] = cmp.mapping.confirm({
    ['<C-h>'] = cmp.mapping.close(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
        behavior = cmp.ConfirmBehavior.Insert,
        select = true
    })
}
-- }}}

-- {{{ Misc keybinds
map('v', '<', '<gv', {noremap = true, silent = false})
map('v', '>', '>gv', {noremap = true, silent = false})
-- }}}

-- {{{ Git status (Fugitive)
map("n", "gs", ":0G<CR>", {})
-- }}}

-- {{{ LSP binds
map('n', '<leader>la', '<cmd>CodeActionMenu<CR>', {})
map('n', '<leader>lf', ':Neoformat<CR>', {noremap = true}) -- format current buffer with neoformat
map('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {}) 
map('n', '<leader>ln', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {})
map('n', '<leader>lp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {})
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', {})

map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', {})
map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', {})
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', {})
map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', {})
map('n', 'gr', ':lua vim.lsp.buf.references()<CR>', {})
-- }}}

-- {{{ Harpoon bindings
map("n", "ga", ":lua require('harpoon.mark').add_file()<CR>", {})
map("n", "gm", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {})
map("n", "gj", ":lua require('harpoon.ui').nav_file(1)<CR>", {})
map("n", "gk", ":lua require('harpoon.ui').nav_file(2)<CR>", {})
map("n", "gl", ":lua require('harpoon.ui').nav_file(3)<CR>", {})
map("n", "g;", ":lua require('harpoon.ui').nav_file(4)<CR>", {})
map("n", "<leader><space>m", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>", {})
map("n", "<leader><space>p", ":!pandoc % -o %<.pdf --from markdown --template eisvogel --listings --toc<CR>", {})
-- }}}

-- {{{ Harpoon will bind to tmux if its running else use terminals
local in_tmux_session = vim.fn.system('echo $TMUX'):find('tmux')
if in_tmux_session then
		map("n", "gt", ":lua require('harpoon.tmux').gotoTerminal(1)<CR>", {})
		map("n", "gy", ":lua require('harpoon.tmux').gotoTerminal(2)<CR>", {})
		map("n", "<leader><space>j", ":lua require('harpoon.tmux').sendCommand(1,1)<cr>", {})
		map("n", "<leader><space>k", ":lua require('harpoon.tmux').sendCommand(1,2)<cr>", {})
		map("n", "<leader><space>l", ":lua require('harpoon.tmux').sendCommand(2,3)<cr>", {})
		map("n", "<leader><space>;", ":lua require('harpoon.tmux').sendCommand(2,4)<cr>", {})
	else
		map("n", "gt", ":lua require('harpoon.term').gotoTerminal(1)<CR>", {})
		map("n", "gy", ":lua require('harpoon.term').gotoTerminal(2)<CR>", {})
		map("n", "<leader><space>j", ":lua require('harpoon.term').sendCommand(1,1)<cr>", {})
		map("n", "<leader><space>k", ":lua require('harpoon.term').sendCommand(1,2)<cr>", {})
		map("n", "<leader><space>l", ":lua require('harpoon.term').sendCommand(2,3)<cr>", {})
		map("n", "<leader><space>;", ":lua require('harpoon.term').sendCommand(2,4)<cr>", {})
	end
-- }}}

-- {{{ buffer management
map('n', '<leader>x', ':bd!<CR>', {noremap = true})
-- }}}

-- {{{ terminal commands
map('n', '<leader><CR>', ':vs | terminal<CR>i', opt)
map('n', '<leader>\\', ':sp | terminal<CR>i', opt)
map('t', '<esc>', '<C-\\><C-n>', opt)
-- }}}

-- {{{ telescope pullup
map('n', '<leader>ff', ':Telescope find_files<CR>', {noremap = true})
map('n', '<leader>fr', ':Telescope live_grep<CR>', {noremap = true})
map('n', '<leader>fc', ':Telescope git_commits<CR>', {noremap = true})
map('n', '<leader>fb', ':Telescope git_branches<CR>', {noremap = true})
-- }}}

return M
