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

  -- formatters
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = { "mason.nvim" },
  --   root_has_file = function(files)
  --     return function(utils)
  --       return utils.root_has_file(files)
  --     end
  --   end,
  --   opts = function(plugin)
  --     local root_has_file = plugin.root_has_file
  --     local null_ls = require("null-ls")
  --     local formatting = null_ls.builtins.formatting
  --     local stylua_root_files = { "stylua.toml", ".stylua.toml" }
  --     local modifier = {
  --       stylua_formatting = {
  --         condition = root_has_file(stylua_root_files),
  --       },
  --     }
  --     return {
  --       debug = false,
  --       -- You can then register sources by passing a sources list into your setup function:
  --       -- using `with()`, which modifies a subset of the source's default options
  --       sources = {
  --         formatting.stylua.with(modifier.stylua_formatting),
  --         formatting.markdownlint,
  --         formatting.beautysh.with({ extra_args = { "--indent-size", "2" } }),
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     local null_ls = require("null-ls")
  --     null_ls.setup(opts)
  --   end,
  -- },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers", -- This is the important bit!
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          -- ["core.integrations.telescope"] = {},
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
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                local leader = keybinds.leader

                -- hop-link
                keybinds.remap_key("norg", "n", "<CR>", "<CR><CR>")

                -- new note
                keybinds.remap_key("norg", "n", leader .. "nn", "ZZ")
              end,
            }
          },
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
              markup_preset = "dimmed",
              dim_code_blocks = {
                enabled = false,
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
              autodetect = true,
              autochdir = true,
            },
          },
          ["core.esupports.metagen"] = {
            config = {
              type = "<leader>om",
            },
          },
          ["core.presenter"] = {
            config = {
              zen_mode = "zen-mode",
            }
          },
          ["core.qol.toc"] = {},
          ["core.export"] = {},
          ["core.export.markdown"] = {
            config = {
              extensions = "all",
            },
          },
        },
      }
      vim.keymap.set("n", "<leader>ne", ":Neorg export to-file ", { desc = "Export file" })
      vim.keymap.set("n", "<leader>nt", "<cmd>Neorg tangle current-file<cr>", { desc = "Tangle file" })
      vim.keymap.set("n", "<leader>ni", "<cmd>Neorg inject-metadata<cr>", { desc = "Inject" })
      vim.keymap.set("n", "<leader>nu", "<cmd>Neorg update-metadata<cr>", { desc = "Update" })
      vim.keymap.set("n", "<leader>nr", "<cmd>Neorg toc right<cr>", { desc = "Open ToC (right)" })
      vim.keymap.set(
        "n",
        "<leader>nq",
        "<cmd>Neorg toc qflist<cr>",
        { desc = "Open ToC (quickfix list)" }
      )
    end,
  }


}
