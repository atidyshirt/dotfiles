local servers = {
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        inlayHints = true,
      },
    },
  },
  eslint = {
    settings = {
      workingDirectory = { mode = "auto" },
    },
  },
  clangd = {},
  cssls = {},
  html = {},
  jsonls = {},
  sqlls = {},
  intelephense = {}, -- php language server
  jdtls = {
    disabled = true,
  },
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
  -- TODO: Removal if typescript-tools is successful
  -- tsserver = {
  --   settings = {
  --     typescript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = "all",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = true,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = true,
  --       },
  --     },
  --     javascript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = "all",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = true,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = true,
  --       },
  --     },
  --   },
  -- },

  -- python language server
  pyright = {
    -- disable hint of pyright
    capabilities = (function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
      return capabilities
    end)(),
    settings = {
      python = {
        analysis = {
          indexing = true,
          typeCheckingMode = "basic",
          diagnosticMode = "openFilesOnly",
          autoImportCompletions = true,
          autoSearchPaths = true,
          inlayHints = {
            variableTypes = true,
            functionReturnTypes = true,
          },
          useLibraryCodeForTypes = true,
          diagnosticSeverityOverrides = {
            reportGeneralTypeIssues = "none",
            reportOptionalMemberAccess = "none",
            reportOptionalSubscript = "none",
            reportPrivateImportUsage = "none",
          },
        },
      },
    },
  },
  pylsp = {
    -- reference: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
    settings = {
      pylsp = {
        plugins = {
          jedi_definition = {
            enabled = false,
            follow_imports = false,
            follow_builtin_imports = false,
            follow_builtin_definitions = false,
          },
          jedi_rename = { enabled = true },
          jedi_completion = { enabled = false },
          jedi_hover = { enabled = true },
          -- type checker
          pylsp_mypy = {
            enabled = false,
            live_mode = false,
            dmypy = false,
            report_progress = false,
          },
          -- Disabled ones:
          flake8 = { enabled = false },
          mccabe = { enabled = false },
          preload = { enabled = false },
          pycodestyle = { enabled = false },
          pyflakes = { enabled = false },
          pylint = { enabled = false },
          rope = { enabled = false },
          rope_completion = { enabled = false },
          rope_rename = { enabled = false },
          yapf = { enabled = false },
          pylsp_black = { enabled = false },
          pyls_isort = { enabled = false },
          autopep8 = { enabled = false },
        },
      },
    },
  },
}
return servers
