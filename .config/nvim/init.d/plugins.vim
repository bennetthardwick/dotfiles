call plug#begin('~/.vim/plugged')

" Visuals "
Plug 'morhetz/gruvbox'

" Util "
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" Plug 'SirVer/ultisnips'
Plug 'elixir-editors/vim-elixir'

Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'

Plug 'neovim/nvim-lspconfig'

" Language Server "
Plug 'neoclide/coc.nvim'

call plug#end()

colorscheme gruvbox
