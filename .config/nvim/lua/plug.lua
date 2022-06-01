require('packer').startup({
    function(use)
        -- packer self management
        use('wbthomason/packer.nvim')
		

        -- {{{ lsp/autocompletion/snippets
        -- lsp plugins
        use('neovim/nvim-lspconfig')
        use('onsails/lspkind-nvim')
        use('williamboman/nvim-lsp-installer')
        use({'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu'})

        -- autocompletion
        use({
            'hrsh7th/nvim-cmp',
            requires = {
                {'hrsh7th/cmp-nvim-lsp'}, 
				{'hrsh7th/cmp-path'},
                {'hrsh7th/cmp-buffer'}
            }
        })

        -- snippets
        use('sirver/ultisnips')
        use('quangnguyen30192/cmp-nvim-ultisnips')
        -- }}}

        -- {{{ utility plugins
        -- these plugins are all realted to editor configs
        use({
            'nvim-lualine/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true}
        })
        -- use('kdheepak/tabline.nvim')
        use({
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        })
        use({'nvim-telescope/telescope-fzf-native.nvim', run = 'make'})
        use('windwp/nvim-autopairs')
        use('unblevable/quick-scope')
        use('terrortylor/nvim-comment')
        use('sbdchd/neoformat')
        use({'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}})
		use("kyazdani42/nvim-tree.lua")
        -- }}}

        -- {{{ imporved syntax plugins
        -- these add in a bit more bling and flair to nvim
        use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
        use('norcalli/nvim-colorizer.lua')
        -- }}}

        -- {{{ The best plugins
        use('ThePrimeagen/harpoon')
        use('tpope/vim-fugitive')
        use('tpope/vim-surround')
        -- }}}

        -- {{{ tmux
        use('christoomey/vim-tmux-navigator')
        use('vimpostor/vim-tpipeline')
        -- }}}

        -- {{{ themes
        -- popular themes incoming
        use('shaunsingh/nord.nvim')
        use('sainnhe/gruvbox-material')
		use("projekt0n/github-nvim-theme")
        -- }}}
    end,
    -- display packer dialouge in the center in a floating window
    config = {display = {open_fn = require('packer.util').float}}
})
