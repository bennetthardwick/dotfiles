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

set wildignore+=*/node_modules/**/*
set wildignore+=*.aux

set diffopt+=vertical 

set path+=./**

autocmd BufEnter * :syntax sync fromstart
autocmd TermOpen * :setlocal signcolumn=no nonumber norelativenumber

syntax on
filetype plugin indent on
