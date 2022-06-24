-- n, v, i, t = mode names
local function termcodes(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function map(mode, bind, exec, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

map("n", "ga", ":lua require('harpoon.mark').add_file()<CR>", {})
map("n", "gm", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {})
map("n", "gj", ":lua require('harpoon.ui').nav_file(1)<CR>", {})
map("n", "gk", ":lua require('harpoon.ui').nav_file(2)<CR>", {})
map("n", "gl", ":lua require('harpoon.ui').nav_file(3)<CR>", {})
map("n", "g;", ":lua require('harpoon.ui').nav_file(4)<CR>", {})
map("n", "<leader><space>m", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>", {})
map("n", "<leader><space>p", ":!pandoc % -o %<.pdf --from markdown --template eisvogel --listings --toc<CR>", {})
map('v', '<', '<gv', {noremap = true, silent = false})
map('v', '>', '>gv', {noremap = true, silent = false})

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

local M = {}

-- }}}

M.general = {

   i = {
      -- go to  beginning and end
      ["<C-b>"] = { "<ESC>^i", "論 beginning of line" },
      ["<C-e>"] = { "<End>", "壟 end of line" },

      -- NOTE: overwritten with tmux navigator
      -- navigate within insert mode
      -- ["<C-h>"] = { "<Left>", "  move left" },
      -- ["<C-l>"] = { "<Right>", " move right" },
      -- ["<C-j>"] = { "<Down>", " move down" },
      -- ["<C-k>"] = { "<Up>", " move up" },
   },

   n = {

      ["<ESC>"] = { "<cmd> noh <CR>", "  no highlight" },

      -- switch between windows
      ["<C-h>"] = { "<C-w>h", " window left" },
      ["<C-l>"] = { "<C-w>l", " window right" },
      ["<C-j>"] = { "<C-w>j", " window down" },
      ["<C-k>"] = { "<C-w>k", " window up" },

      -- update nvchad
      -- ["<leader>u"] = { "", "  Update" },
      -- ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "  update nvchad" },
   },

   t = {
      ["<esc>"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
   },
}

M.tabufline = {

   n = {
      -- cycle through buffers
      ["<TAB>"] = { "<cmd> Tbufnext <CR>", "  goto next buffer" },
      ["<S-Tab>"] = { "<cmd> Tbufprev <CR> ", "  goto prev buffer" },

      -- cycle through tabs
      ["<leader>t"] = { "", "   tabs" },
      ["<leader>tp"] = { "<cmd> tabprevious <CR>", "  goto next tab" },
      ["<leader>tn"] = { "<cmd> tabnext <CR> ", "  goto prev tab" },

      -- close buffer + hide terminal buffer
      ["<leader>x"] = {
         function()
            require("core.utils").close_buffer()
         end,
         "   close buffer",
      },
   },
}

M.comment = {

   -- toggle comment in both modes
   n = {
      ["<leader>/"] = {
         function()
            require("Comment.api").toggle_current_linewise()
         end,

         "蘒  toggle comment",
      },
   },

   v = {
      ["<leader>/"] = {
         "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
         "蘒  toggle comment",
      },
   },
}

M.lspconfig = {
   -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

   n = {
      ["gD"] = {
         function()
            vim.lsp.buf.declaration()
         end,
         "   lsp declaration",
      },

      ["gd"] = {
         function()
            vim.lsp.buf.definition()
         end,
         "   lsp definition",
      },

      ["K"] = {
         function()
            vim.lsp.buf.hover()
         end,
         "   lsp hover",
      },

      ["gi"] = {
         function()
            vim.lsp.buf.implementation()
         end,
         "   lsp implementation",
      },

      ["gs"] = {
          "<cmd>:0G<CR>",
          "   Git status",
      },

      ["<leader>l"] = {"", "    lsp" },

      ["<leader>ls"] = {
         function()
            vim.lsp.buf.signature_help()
         end,
         "   lsp signature_help",
      },

      ["<leader>lD"] = {
         function()
            vim.lsp.buf.type_definition()
         end,
         "   lsp definition type",
      },

      ["<leader>lr"] = {
         function()
            require("nvchad.ui.renamer").open()
         end,
         "   lsp rename",
      },

      ["<leader>la"] = {
         function()
            vim.lsp.buf.code_action()
         end,
         "   lsp code_action",
      },

      ["gr"] = {
         function()
            vim.lsp.buf.references()
         end,
         "   lsp references",
      },

      ["<leader>lf"] = {
         function()
            vim.diagnostic.open_float()
         end,
         "   floating diagnostic",
      },

      ["[d"] = {
         function()
            vim.diagnostic.goto_prev()
         end,
         "   goto prev",
      },

      ["]d"] = {
         function()
            vim.diagnostic.goto_next()
         end,
         "   goto_next",
      },

      ["<leader>ll"] = {
         function()
            vim.diagnostic.setloclist()
         end,
         "   diagnostic setloclist",
      },

      ["<leader>ln"] = {
         function()
            vim.lsp.buf.formatting()
         end,
         "   lsp formatting",
      },

      ["<leader>w"] = {"", "    workspaces" },

      -- ["<leader>o"] = {"", "    org" },

      ["<leader>wa"] = {
         function()
            vim.lsp.buf.add_workspace_folder()
         end,
         "   add workspace folder",
      },

      ["<leader>wr"] = {
         function()
            vim.lsp.buf.remove_workspace_folder()
         end,
         "   remove workspace folder",
      },

      ["<leader>wl"] = {
         function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
         end,
         "   list workspace folders",
      },
   },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "   focus nvimtree" },
  },
}

M.telescope = {
    n = {
        ["<leader>f"] = {"", "   find" },
        ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
        ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
        ["<leader>fc"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
        ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "  find files" },
        ["<leader>ft"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },
        ["<leader>fr"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
        ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "   find oldfiles" },
    },
}

M.blankline = {
   n = {
      ["<leader>lc"] = {
         function()
            local ok, start = require("indent_blankline.utils").get_current_context(
               vim.g.indent_blankline_context_patterns,
               vim.g.indent_blankline_use_treesitter_scope
            )

            if ok then
               vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
               vim.cmd [[normal! _]]
            end
         end,

         "  Jump to current_context",
      },
   },
}

return M
