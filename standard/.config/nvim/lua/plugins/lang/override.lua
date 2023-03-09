return {
    {
        "neovim/nvim-lspconfig",
        init = function()
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            local format = require("lazyvim.plugins.lsp.format").format

            -- overiding 'goto' keys
            keys[#keys + 1] = { "gt", false }
            keys[#keys + 1] = {
                "gd",
                function()
                    vim.lsp.buf.definition()
                end,
            }

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
    },
}
