" ============================================== INSTALL PLUG ==========================================================
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Plugins
call plug#begin('~/.vim/plugged')
    Plug 'https://github.com/tpope/vim-fugitive'
    Plug 'https://github.com/tpope/vim-surround'
    Plug 'https://github.com/tpope/vim-sleuth'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'https://github.com/christoomey/vim-tmux-navigator'
    Plug 'https://github.com/sainnhe/gruvbox-material'
call plug#end()

" Mappings
let mapleader = "\<Space>"
noremap gs :0G<CR>
noremap <leader>e :Ex<CR>
noremap <ESC><ESC> :nohlsearch<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fw :Ag<CR>

" Settings
set title
set nocompatible
set autoread
set encoding=utf-8
set showcmd
set mouse=a
set relativenumber
set diffopt+=iwhite
set laststatus=2
set ttyfast

set wildignorecase
set hlsearch
set incsearch
set ignorecase
set smartcase

set timeoutlen=400

syntax enable
set background=dark
colorscheme gruvbox-material
