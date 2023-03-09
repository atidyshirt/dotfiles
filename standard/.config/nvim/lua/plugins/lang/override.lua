local present, cmp = pcall(require, "cmp")
if not present then
    return
end

return {
    {
        "neovim/nvim-lspconfig",
        servers = { eslint = {} },
        init = function()
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            local format = require("lazyvim.plugins.lsp.format").format

            -- override 'code' bindings
            keys[#keys + 1] = { "gt", false }
            keys[#keys + 1] = { "<leader>cd", false }
            keys[#keys + 1] = { "<leader>cl", false }
            keys[#keys + 1] = { "<leader>cr", false }
            keys[#keys + 1] = { "<leader>cf", false }
            keys[#keys + 1] = { "<leader>cf", false }
            keys[#keys + 1] = { "<leader>la", false }

            -- creating standard 'lsp' bindings
            keys[#keys + 1] = {
                "<leader>lp",
                function()
                    vim.diagnostic.goto_prev()
                end,
            }
            keys[#keys + 1] = {
                "<leader>ln",
                function()
                    vim.diagnostic.goto_next()
                end,
            }

            keys[#keys + 1] = { "<leader>ld", vim.diagnostic.open_float, desc = "Line Diagnostics" }
            keys[#keys + 1] = { "<leader>ll", "<cmd>LspInfo<cr>", desc = "Lsp Info" }
            keys[#keys + 1] = { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
            keys[#keys + 1] = { "<leader>lf", format, desc = "Format Document", has = "documentFormatting" }
            keys[#keys + 1] =
                { "<leader>lf", format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" }
            keys[#keys + 1] = {
                "<leader>la",
                vim.lsp.buf.code_action,
                desc = "Code Action",
                mode = { "n", "v" },
                has = "codeAction",
            }
        end,
        setup = {
            eslint = function()
                require("lazyvim.util").on_attach(function(client)
                    if client.name == "eslint" then
                        client.server_capabilities.documentFormattingProvider = true
                    elseif client.name == "tsserver" then
                        client.server_capabilities.documentFormattingProvider = false
                    end
                end)
            end,
        },
    },
    {
        "hrsh7th/nvim-cmp",
        opts = {
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                }),
                ["<C-j>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif require("luasnip").expand_or_jumpable() then
                        vim.fn.feedkeys(
                            vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
                            ""
                        )
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
                ["<C-k>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif require("luasnip").jumpable(-1) then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
            }),
        },
    },
}
