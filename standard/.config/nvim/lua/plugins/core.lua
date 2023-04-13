return {
    { "folke/lazy.nvim", version = false },
    {
        "atidyshirt/LazyVim",
        version = false,
        opts = {
            colorscheme = "gruvbox-material",
        },
    },

    {
        "mauricekraus/winbar.nvim",
        init = function()
            require("winbar").setup({
                enabled = true,
                show_file_path = false,
                show_symbols = true,

                colors = {
                    path = "", -- You can customize colors like #c946fd
                    file_name = "#a9b665",
                },

                icons = {
                    file_icon_default = "",
                    separator = ">",
                    editor_state = "●",
                    lock_icon = "",
                },

                exclude_filetype = {
                    "help",
                    "startify",
                    "dashboard",
                    "packer",
                    "neogitstatus",
                    "NvimTree",
                    "Trouble",
                    "alpha",
                    "lir",
                    "Outline",
                    "spectre_panel",
                    "toggleterm",
                    "qf",
                },
            })
        end,
    },
}
