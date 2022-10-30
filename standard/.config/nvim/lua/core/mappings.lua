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
    ["<leader>x"] = {":bd!<CR>", "Close buffer"},
    ["<leader>X"] = {":%bd!|e#<CR>", "Close other buffers"},

    -- Harpoon
    ["ga"] = { ":lua require('harpoon.mark').add_file()<CR>", "Harpoon add" },
    ["gm"] = { ":lua require('harpoon.ui').toggle_quick_menu()<CR>", "Harpoon menu" },
    ["gj"] = { ":lua require('harpoon.ui').nav_file(1)<CR>", "Harpoon file 1" },
    ["gk"] = { ":lua require('harpoon.ui').nav_file(2)<CR>", "Harpoon file 2" },
    ["gl"] = { ":lua require('harpoon.ui').nav_file(3)<CR>", "Harpoon file 3" },
    ["g;"] = { ":lua require('harpoon.ui').nav_file(4)<CR>", "Harpoon file 4" },
    ["gt"] = { ":lua require('harpoon.tmux').gotoTerminal(1)<CR>", "Terminal 1" },
    ["gy"] = { ":lua require('harpoon.tmux').gotoTerminal(2)<CR>", "Terminal 2" },
    ["<leader><space>m"] = { ":lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>" , "Harpoon command menu"},
    ["<leader><space>j"] = { ":lua require('harpoon.tmux').sendCommand(1,1)<cr>", "Send Command 1" },
    ["<leader><space>k"] = { ":lua require('harpoon.tmux').sendCommand(1,2)<cr>", "Send Command 2" },
    ["<leader><space>l"] = { ":lua require('harpoon.tmux').sendCommand(2,3)<cr>", "Send Command 3" },
    ["<leader><space>;"] = { ":lua require('harpoon.tmux').sendCommand(2,4)<cr>", "Send Command 4" },
  },

  t = { ["<esc>"] = { termcodes "<C-\\><C-N>", "Escape terminal mode" } },

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
      "Goto next buffer",
    },

    ["H"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    ["<leader>x"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "Close buffer",
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
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
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
      "Lsp declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "Lsp definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "Lsp hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "Lsp implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "Lsp signature_help",
    },

    ["<leader>lr"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "Lsp rename",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "Lsp references",
    },

    ["lp"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "Goto prev diagnostic",
    },

    ["ln"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "Goto next diagnostic",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Quickfix diagnostics",
    },

    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
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
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "Show keys" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
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
