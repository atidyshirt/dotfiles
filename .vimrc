" This config is the bear minimum I need to be productive

" setup
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" open neovim
" :PlugInstall
" :CocInstall coc-explorer coc-python coc-tsserver coc-json
" ^ add what you want to coc


syntax on

set noerrorbells 
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set relativenumber
set number
set splitbelow
set splitright
set cursorline
set nowrap
set smartcase
set noswapfile
set nobackup
set incsearch

let mapleader = " "

call plug#begin('~/.vim/plugged')
  Plug 'gruvbox-community/gruvbox'
  Plug 'tpope/vim-fugitive'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf'
  Plug 'leafgarland/typescript-vim'
  Plug 'unblevable/quick-scope'
call plug#end()

" Colorscheme
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark

" plugin setups
let g:fzf_layout = { 'down': '~40%' }

" Binds
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

nmap <leader>f :FZF<CR>
nmap <leader>e :CocCommand explorer<CR>

