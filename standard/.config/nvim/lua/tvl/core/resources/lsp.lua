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
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "stylua",
        "markdownlint",
        "beautysh",
      },
      automatic_setup = true,
    },
  },
}
