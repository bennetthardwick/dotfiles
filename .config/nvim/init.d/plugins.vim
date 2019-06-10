set runtimepath+=~/.fzf

call plug#begin('~/.vim/plugged')

" Visuals "
Plug 'morhetz/gruvbox'

" Util "
Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'

Plug 'sheerun/vim-polyglot'

" Language Server "
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

call plug#end()
