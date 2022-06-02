local lsp_installer = require "nvim-lsp-installer"

lsp_installer.setup({
    ensure_installed = {
		"pyright",
		"tsserver",
		"bashls",
		"ccls",
		"clangd",
		"cmake",
		"dockerls",
		"zk",
		"diagnosticls",
		"arduino_language_server",
		"angularls",
		"sumneko_lua"
	},
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local servers = { "pyright", "tsserver", "bashls", "cmake", "ccls", "clangd", "dockerls", "zk", "diagnosticls", "arduino_language_server", "angularls", "sumneko_lua" }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {}
end
