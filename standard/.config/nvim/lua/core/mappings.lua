-- n, v, i, t = mode names

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {
  n = {
    ["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["<leader>tt"] = {
      function()
        require("base46").toggle_theme()
      end,
      "toggle theme",
    },
    -- vim-fugative
    ["gs"] = {":0G<CR>"},
    ["<leader>x"] = {":bd!<CR>"},
    ["<leader>X"] = {":%bd!|e#<CR>"},

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

  t = { ["<esc>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" } },

  v = {
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
    ['<'] = { '<gv', opts = {noremap = true, silent = false} },
    ['>'] = { '>gv', opts = {noremap = true, silent = false} },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["L"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "goto next buffer",
    },

    ["H"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "goto prev buffer",
    },

    ["<leader>x"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
    },
  },
}

M.comment = {
  plugin = true,
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M.lspconfig = {
  plugin = true,
  n = {
    ['<leader>la'] = { '<cmd>CodeActionMenu<CR>' },
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "lsp declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "lsp implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },

    ["<leader>lr"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "lsp references",
    },

    ["lp"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "goto prev",
    },

    ["ln"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },

    ["<leader>lf"] = {
      function()
        vim.lsp.buf.formatting {}
      end,
      "lsp formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "list workspace folders",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },

    -- new

    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "new horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "new vertical term",
    },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "which-key query lookup",
    },
  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>cc"] = {
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

      "Jump to current_context",
    },
  },
}

return M
