return {
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>lj",
        "<cmd>TSJToggle<cr>",
        desc = "Split / Join",
      },
    },
    opts = { use_default_keymaps = false },
  },

  { "vitalk/vim-shebang" },

  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = { "InsertEnter", "CmdlineEnter" },
    commit = "b8c2a62b3bd3827aa059b43be3dd4b5c45037d65",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
      cmp.setup.filetype("java", {
        completion = {
          keyword_length = 2,
        },
      })
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-l>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        }),
        sources = cmp.config.sources({
          -- { name = "codeium" },
          { name = "neorg" },
          { name = "nvim_lsp", keyword_length = 2 },
          { name = "luasnip" },
          { name = "buffer", keyword_length = 3 },
          { name = "path" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local icons = require("tvl.core.icons")
            item.kind = icons.kinds[item.kind]
            if entry.source.name == "codeium" then
              item.kind = icons.misc.codeium
              item.kind_hl_group = "CmpItemKindVariable"
            end
            item.menu = ({
              codeium = "Codeium",
              nvim_lsp = "Lsp",
              luasnip = "Snippet",
              buffer = "Buffer",
              path = "Path",
            })[entry.source.name]
            return item
          end,
        },
        experimental = { ghost_text = true },
      }
    end,
  },

  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    'dmmulroy/tsc.nvim',
    config = function ()
      require('tsc').setup()
    end
  },

  {
    "ray-x/lsp_signature.nvim",
    event = { "InsertEnter" },
    opts = {
      floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      hint_scheme = "Comment", -- highlight group for the virtual text
    },
  },

  {
    "glepnir/lspsaga.nvim",
    lazy = true,
    config = function()
      require("lspsaga").setup({})
    end,
  },

  { "folke/neodev.nvim", opts = {} }
}
