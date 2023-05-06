local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = {
        {
            "atidyshirt/LazyVim",
            import = "lazyvim.plugins",
        },
        { import = "lazyvim.plugins.extras.lang.typescript" },
        { import = "lazyvim.plugins.extras.lang.json" },
        { import = "lazyvim.plugins.extras.formatting.prettier" },
        { import = "lazyvim.plugins.extras.linting.eslint" },
        { import = "plugins.lang" },
        { import = "plugins" },
    },
    autoformat = false,
    defaults = {
        lazy = false,
        version = false,
    },
    install = { colorscheme = { "gruvbox" } },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
