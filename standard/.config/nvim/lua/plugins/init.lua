return {
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
        "ThePrimeagen/refactoring.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            require("refactoring").setup({})
            require("telescope").load_extension("refactoring")
        end,
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

    { "Bekaboo/deadcolumn.nvim", config = true },

    -- local history
    {
        "dinhhuy258/vim-local-history",
        config = function()
            local path = os.getenv("HOME") .. "/.config"
            vim.g.local_history_path = path .. "/.local-history"
            vim.g.local_history_max_changes = 100
        end,
        build = ":UpdateRemotePlugins",
    },
}
