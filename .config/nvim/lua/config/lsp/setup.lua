--[[
	LSP setup script for default capibilities
--]] local fn = vim.fn

-- {{{ on_attach config
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- {{{ Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
    end
end
-- }}}

-- }}}

-- {{{ standard paths for lsp servers

-- check if lspservers directory exists in data stdpath
-- and create one if not
local lspserver_dir = fn.isdirectory(fn.stdpath('data') .. '/lspservers')
if lspserver_dir == 0 then fn.mkdir(fn.stdpath('data') .. '/lspservers') end

-- }}}
