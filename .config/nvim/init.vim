call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'morhetz/gruvbox'
Plug 'ervandew/supertab'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kana/vim-surround'
Plug 'exvim/ex-searchcompl'
Plug 'mhartington/nvim-typescript'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/deoplete.nvim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'zchee/deoplete-clang'
Plug 'donRaphaco/neotex', { 'for': 'tex' }

call plug#end()

set number
set relativenumber
syntax on
set mouse=a
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set updatetime=100
set background=dark
set clipboard+=unnamedplus
filetype plugin indent on

let g:javascript_plugin_jsdoc=1
let g:javascript_plugin_ngdoc=1

let g:ycm_server_python_interpreter="python2"
let g:ycm_global_ycm_extra_conf="~/.vim/.ycmd_flags.py"

let g:airline_powerline_fonts = 1

let g:gruvbox_contrast_dark = "medium"

let g:deoplete#enable_at_startup = 1

colorscheme gruvbox

set wildignore+=*/node_modules/**/*
