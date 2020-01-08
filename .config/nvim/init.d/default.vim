" -- Vim Config -- "

if &compatible
 set nocompatible
endif

set number relativenumber
set shiftwidth=2
set mouse=a
set expandtab
set autoindent
set smartindent
set clipboard+=unnamedplus
set ignorecase smartcase
set cpoptions+=y

set wildignore+=*/node_modules/**/*
set wildignore+=*.aux

set diffopt+=vertical 

set path+=./**
set cursorline
set wildoptions=pum
set pumblend=8
highlight PmenuSel blend=0

autocmd BufEnter * :syntax sync fromstart
autocmd TermOpen * :setlocal signcolumn=no nonumber norelativenumber

syntax on
filetype plugin indent on
