" -- Benny's Default Vim Config --
" You can find out what different things do by opening this file in Vim /
" Neovim and pressing <Shift-K> when your cursor is on a word. This will take
" you to the man pages. If you're lazy, you can read my comments.
"

if &compatible
 " If called from Vim, make sure it's nocompatible
 set nocompatible
endif

" The most important option. Set the line numbers to be relative instead of
" absolute.
set number relativenumber

" Set a default shiftwidth of 2, this will typically automatically be set by
" the filetype / linter, 2 is a good default.
set shiftwidth=2
set tabstop=2
" Make Vim work with the mouse (clicking, scrolling, etc.)
set mouse=a
" Use spaces instead of tabs when the tab key is pressed
set expandtab
" Keep indentation when going to the next line
set autoindent
" Add a tab depending on syntax (works for C like languages)
set smartindent
" Yank to the system clipboard (this sometimes makes large macros stop
" working)
set clipboard+=unnamedplus
" When searching with / ignore the case unless a term with uppercase letters
" is entered
set ignorecase smartcase
" Allow yank to be repeated with the "." command. This is useful when yanking to
" a different clipboard or using the "append yank" feature.
set cpoptions+=y

" Generally ignore a bunch of different files
set wildignore+=*/node_modules/**/*
set wildignore+=*.aux

" Diff vertically instead of horizontally
set diffopt+=vertical 

set path+=./**

if has('nvim')
  " Show a line where the current cursor is
  set cursorline

  " Show completion items using the pop-up-menu (pum)
  set wildoptions=pum
  " Give the pum some transparency
  set pumblend=0

  highlight PmenuSel blend=0

  " Make sure the terminal buffer has no numbers and no sign column
  autocmd TermOpen * :setlocal signcolumn=no nonumber norelativenumber

  set termguicolors

  set breakindent
  set formatoptions=l
  set lbr

  lua require('init')

  colorscheme gruvbox
  set background=dark

  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_Co=256

  nnoremap <silent> <leader>sv :source ~/.config/nvim/init.vim<CR>
  nnoremap <silent> <leader>t :r!date +\%H:\%M<CR>A - 

  let g:gruvbox_contrast_dark = "medium"

  " set conceallevel=2
  " set concealcursor=nc

  " Statusline
  function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
      return luaeval("require('lsp-status').status()")
    endif
  
    return ''
  endfunction

  tnoremap <Esc> <C-\><C-n>

  set statusline=
  set statusline+=%f\ 
  set statusline+=%h%m%r
  set statusline+=\ %{LspStatus()}
  set statusline+=%=
  set statusline+=\ %y
  set statusline+=\ %l:%c
  set statusline+=\ %P
endif

" Yank the current word and search using Rg
" nnoremap <silent> <leader>s yiw:Rg <C-R>"<CR>

" Use \[ and \] to vertically resize splits
nnoremap <silent> <leader>] :exe "vertical resize " . (winwidth(0) + 30)<CR>
nnoremap <silent> <leader>[ :exe "vertical resize " . (winwidth(0) - 30)<CR>

" Use \- and \= to horizontally resize splits
nnoremap <silent> <leader>= :exe "resize " . (winheight(0) + 10)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) - 10)<CR>

nnoremap <silent> <leader>l :later 1f<CR>
nnoremap <silent> <leader>k :earlier 1f<CR>

" Sync syntax from the start of the file when opening a buffer. This is known
" to be slow but hasn't been too bad for me.
autocmd BufEnter * :syntax sync fromstart

syntax on
filetype plugin indent on

" Enable undo file so you can undo after saving
if has('persistent_undo')
  silent !mkdir -p $HOME/.vim/undo
  set undofile
  set undodir=$HOME/.vim/undo
endif
