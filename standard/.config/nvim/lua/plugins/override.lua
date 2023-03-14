return {
    {
        "numToStr/Comment.nvim",
        module = "Comment",
        keys = { "gc", "gb" },
        config = function()
            vim.keymap.set("n", "<leader>/", function()
                require("Comment.api").toggle.linewise.current()
            end)
            vim.keymap.set(
                "v",
                "<leader>/",
                "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
            )
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        init = function()
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            local is_git_files = function()
                vim.fn.system("git rev-parse --is-inside-work-tree")
                if vim.v.shell_error == 0 then
                    return "<cmd> Telescope git_files <CR>"
                else
                    return "<cmd> Telescope find_files <CR>"
                end
            end

            keys[#keys + 1] = { "<leader>ff", is_git_files() }
            keys[#keys + 1] = {
                "<leader>/",
                function()
                    require("Comment.api").toggle.linewise.current()
                end,
            }
            keys[#keys + 1] = { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>" }
            keys[#keys + 1] = { "<leader>fw", "<cmd> Telescope live_grep <CR>" }
            keys[#keys + 1] = { "<leader>fb", "<cmd> Telescope buffers <CR>" }
            keys[#keys + 1] = { "<leader>fh", "<cmd> Telescope help_tags <CR>" }
            keys[#keys + 1] = { "<leader>fo", "<cmd> Telescope oldfiles <CR>" }
            keys[#keys + 1] = { "<leader>tk", "<cmd> Telescope keymaps <CR>" }
            keys[#keys + 1] = { "<leader>cm", "<cmd> Telescope git_commits <CR>" }
            keys[#keys + 1] = { "<leader>gt", "<cmd> Telescope git_status <CR>" }
        end,
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event = "BufReadPost",
        opts = {},
    },

    {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({})
        end,
        opts = { use_default_keymaps = false },
    },
    {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({})
        end,
        opts = { use_default_keymaps = false },
    },

    {
        "mini.ai",
        enabled = false,
    },

    {
        "noice.nvim",
        enabled = false,
    },
    {
        "mini.comment",
        enabled = false,
    },
    {
        "mini.pairs",
        enabled = false,
    },
    {
        "mini.surround",
        enabled = false,
    },
    {
        "mini.bufremove",
        enabled = false,
    },
    {
        "which-key.nvim",
        enabled = false,
    },
    {
        "leap.nvim",
        enabled = false,
    },
    {
        "flit.nvim",
        enabled = false,
    },
    {
        "flit.nvim",
        enabled = false,
    },
    {
        "bufferline.nvim",
        enabled = false,
    },
    {
        "nvim-spectre",
        enabled = false,
    },
}
