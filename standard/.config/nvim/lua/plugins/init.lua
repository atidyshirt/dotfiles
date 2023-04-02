return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function(_, _)
            require("treesitter-context").setup({ enable = true })
        end,
    },

    {
        "cbochs/grapple.nvim",
    },

    {
        "cbochs/portal.nvim",
        keys = {
            { "<leader>i", "<cmd>Portal jumplist forward<cr>", desc = "Portal forward" },
            { "<leader>o", "<cmd>Portal jumplist backward<cr>", desc = "Portal backward" },
        },
    },

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

    {
        "liangxianzhe/nap.nvim",
        opts = {
            next_prefix = ",",
            prev_prefix = ",",
            next_repeat = "<c-n>",
            prev_repeat = "<c-p>",
            operators = {
                ["h"] = {
                    next = {
                        command = function()
                            require("gitsigns").next_hunk({ preview = true })
                        end,
                        desc = "Next diff",
                    },
                    prev = {
                        command = function()
                            require("gitsigns").prev_hunk({ preview = true })
                        end,
                        desc = "Prev diff",
                    },
                    mode = { "n", "v", "o" },
                },
            },
        },
    },

    -- my plugins

    -- stylua: ignore
    {
        "ThePrimeagen/harpoon",
        config = true,
        keys = {
            { "ga", function() require('harpoon.mark').add_file() end, desc = "Harpoon add" },
            { "gm", function() require('harpoon.ui').toggle_quick_menu() end, desc = "Harpoon menu" },
            { "gj", function() require('harpoon.ui').nav_file(1) end, desc = "Harpoon file 1" },
            { "gk", function() require('harpoon.ui').nav_file(2) end, desc = "Harpoon file 2" },
            { "gl", function() require('harpoon.ui').nav_file(3) end, desc = "Harpoon file 3" },
            { "g;", function() require('harpoon.ui').nav_file(4) end, desc = "Harpoon file 4" },
            { "gt", function() require('harpoon.tmux').gotoTerminal(1) end, desc = "Terminal 1" },
            { "gy", function() require('harpoon.tmux').gotoTerminal(2) end, desc = "Terminal 2" },
            { "<leader><space>m", function() require('harpoon.cmd-ui').toggle_quick_menu() end, desc = "Harpoon command menu" },
            { "<leader><space>j", function() require('harpoon.tmux').sendCommand(1,1) end, desc = "Send Command 1" },
            { "<leader><space>k", function() require('harpoon.tmux').sendCommand(1,2) end, desc = "Send Command 2" },
            { "<leader><space>l", function() require('harpoon.tmux').sendCommand(2,3) end, desc = "Send Command 3" },
            { "<leader><space>;", function() require('harpoon.tmux').sendCommand(2,4) end, desc = "Send Command 4" },
        },
    },

    {
        "notjedi/nvim-rooter.lua",
        config = function()
            require("nvim-rooter").setup({
                rooter_patterns = {
                    ".git",
                },
                trigger_patterns = { "*" },
                manual = false,
            })
        end,
    },

    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },

    {
        "atidyshirt/markdown-literate",
        config = function()
            require("markdown-literate").setup()
        end,
    },

    { "unblevable/quick-scope" },
    { "tpope/vim-fugitive" },
    { "tpope/vim-surround" },
    { "tpope/vim-sleuth" },
    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            require("nvim-tmux-navigation").setup({
                disable_when_zoomed = true, -- defaults to false
                keybindings = {
                    left = "<C-h>",
                    down = "<C-j>",
                    up = "<C-k>",
                    right = "<C-l>",
                    last_active = "<C-\\>",
                    next = "<C-Space>",
                },
            })
        end,
    },
    { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },
}
