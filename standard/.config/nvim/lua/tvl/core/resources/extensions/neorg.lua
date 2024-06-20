return {
  {
    "nvim-neorg/neorg",
    enabled = vim.g.luarocks_enabled,
    dependencies = {
      "vhyrro/luarocks.nvim",
      "nvim-neorg/neorg-telescope",
      "tamton-aquib/neorg-jupyter",
      "folke/zen-mode.nvim",
    },
    lazy = false,
    version = "*",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.presenter"] = {
          config = {
            zen_mode = "zen-mode",
            }
          },
          ["core.integrations.telescope"] = {},
          ["core.highlights"] = {
            config = {
              highlights = {
                headings = {
                  ["1"] = {
                    title = "+TSTitle",
                    prefix = "+TSTitle",
                  },
                },
                quotes = {
                  ["1"] = {
                    prefix = "+Grey",
                    content = "+Grey",
                  },
                },
              },
            },
          },
          ["external.jupyter"] = {},
          ["core.concealer"] = {
            config = {
              icon_preset = "varied",
              dim_code_blocks = {
                enabled = true,
              },
              icons = {
                delimiter = {
                  horizontal_line = {
                    highlight = "@neorg.delimiters.horizontal_line",
                  },
                },
                code_block = {
                  content_only = true,
                  width = "content",
                  padding = {
                    left = 1,
                    right = 1,
                  },
                  conceal = false,

                  nodes = { "ranged_verbatim_tag" },
                  insert_enabled = true,
                },
              },
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/projects/notes",
              },
              default_workspace = "notes",
              autodetect = true,
              autochdir = true,
            },
          },
          ["core.esupports.metagen"] = {
            config = {
              type = "auto",
            },
          },
          ["core.looking-glass"] = {},
          ["core.qol.todo_items"] = {},
          ["core.integrations.nvim-cmp"] = {},
          ["core.qol.toc"] = {
            config = {
              close_split_on_jump = true,
              toc_split_placement = "right",
            },
          },
          ["core.export"] = {},
          ["core.export.markdown"] = {
            config = {
              extensions = "all",
            },
          },
        },
      }
    end,
  },

  {
    "vhyrro/luarocks.nvim",
    enabled = vim.g.luarocks_enabled,
    priority = 1000,
    config = true,
  },

}
