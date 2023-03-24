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
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event = "BufReadPost",
        opts = {},
    },
}
