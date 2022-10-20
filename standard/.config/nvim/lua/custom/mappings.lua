local M = {}
local opt = {} -- empty opt for maps with no extra options

M.general = {
  n = {
    -- Utility
    ['H'] = { ':bprev<CR>' },
    ['L'] = { ':bnext<CR>' },

    -- Git
    ["gs"] = {":0G<CR>"},

    -- LSP
    ['<leader>ln'] = { '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>' },
    ['<leader>lp'] = { '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>' },
    ['<leader>la'] = { '<cmd>CodeActionMenu<CR>' },
    ["<leader>lr"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },
    -- Harpoon
    ["ga"] = { ":lua require('harpoon.mark').add_file()<CR>" },
    ["gm"] = { ":lua require('harpoon.ui').toggle_quick_menu()<CR>" },
    ["gj"] = { ":lua require('harpoon.ui').nav_file(1)<CR>" },
    ["gk"] = { ":lua require('harpoon.ui').nav_file(2)<CR>" },
    ["gl"] = { ":lua require('harpoon.ui').nav_file(3)<CR>" },
    ["g;"] = { ":lua require('harpoon.ui').nav_file(4)<CR>" },
    ["<leader><space>m"] = { ":lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>" },
    ["<leader><space>p"] = { ":!pandoc % -o %<.pdf --from markdown --template eisvogel --listings --toc<CR>" },
    ["gt"] = { ":lua require('harpoon.tmux').gotoTerminal(1)<CR>" },
    ["gy"] = { ":lua require('harpoon.tmux').gotoTerminal(2)<CR>" },
    ["<leader><space>j"] = { ":lua require('harpoon.tmux').sendCommand(1,1)<cr>" },
    ["<leader><space>k"] = { ":lua require('harpoon.tmux').sendCommand(1,2)<cr>" },
    ["<leader><space>l"] = { ":lua require('harpoon.tmux').sendCommand(2,3)<cr>" },
    ["<leader><space>;"] = { ":lua require('harpoon.tmux').sendCommand(2,4)<cr>" },
  },
  v = {
    ['<'] = { '<gv', opts = {noremap = true, silent = false} },
    ['>'] = { '>gv', opts = {noremap = true, silent = false} },
  },
}

-- more keybinds!
local function map(mode, bind, exec, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

map('n', '<leader><CR>', ':vs | terminal<CR>i', opt)
map('n', '<leader>\\', ':sp | terminal<CR>i', opt)
map('t', '<esc>', '<C-\\><C-n>', opt)
map('n', '<leader>x', ':bd!<CR>', {noremap = true})


return M
