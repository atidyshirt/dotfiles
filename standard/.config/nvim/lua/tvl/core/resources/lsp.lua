return {
  {
    "neovim/nvim-lspconfig",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    keys = {
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", mode = {"n", "v"}, desc = "Code Action" },
      { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
      { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc = "Quickfix" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
      {
        "<leader>lf",
        function()
          vim.lsp.buf.format({
            filter = function(client)
              local exclude_servers = { "lua_ls", "pyright", "pylsp" }
              return not vim.tbl_contains(exclude_servers, client.name)
            end,
          })
        end,
        desc = "Format",
      }
    },

    opts = {
      servers = {
        cssls = {},
        html = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              misc = {
                parameters = {
                  "--log-level=trace",
                },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      attach_handlers = {},
    },
    config = function(_, opts)
      local Util = require("tvl.util")
      Util.on_attach(function(client, buffer)
        require("tvl.config.lsp.navic").attach(client, buffer)
        require("tvl.config.lsp.keymaps").attach(client, buffer)
        require("tvl.config.lsp.inlayhints").attach(client, buffer)
        require("tvl.config.lsp.gitsigns").attach(client, buffer)
      end)

      -- diagnostics
      vim.diagnostic.config(require("tvl.config.lsp.diagnostics")["on"])

      local servers = opts.servers
      local ext_capabilites = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require("tvl.util").capabilities(ext_capabilites)

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if opts.attach_handlers[server] then
          local callback = function(client, buffer)
            if client.name == server then
              opts.attach_handlers[server](client, buffer)
            end
          end
          Util.on_attach(callback)
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local available = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          if not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup_handlers({ setup })
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      window = {
        width = function()
          return math.min(120, vim.o.columns * 0.75)
        end,
      },
      options = {
        number = false,
        relativenumber = false,
        foldcolumn = "0",
        list = false,
        showbreak = "NONE",
        signcolumn = "no",
      },
      plugins = {
        options = {
          cmdheight = 1,
          laststatus = 0,
        },
      },
    }
  },

  {
    "nvim-neorg/neorg",
    dependencies = {
      "nvim-neorg/neorg-telescope",
      "tamton-aquib/neorg-jupyter",
      "folke/zen-mode.nvim",
    },
    cmd = { "Neorg" },
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
  }
}
