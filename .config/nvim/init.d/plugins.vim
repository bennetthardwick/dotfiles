set runtimepath+=~/.fzf

call plug#begin('~/.vim/plugged')

" Visuals "
Plug 'morhetz/gruvbox'

" Util "
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
" Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'

" Language Server "
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
