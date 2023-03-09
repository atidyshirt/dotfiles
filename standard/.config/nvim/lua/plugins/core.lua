return {
    {
        "sainnhe/gruvbox-material",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = true,
    },

    { "folke/lazy.nvim", version = false },
    {
        "LazyVim/LazyVim",
        version = false,
        opts = {
            colorscheme = "gruvbox-material",
            icons = {
                diagnostics = {
                    Error = "E",
                    Warn = "W",
                    Hint = "H",
                    Info = "I",
                },
            },
        },
    },
}
