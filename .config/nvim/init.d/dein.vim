set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein')
  call dein#add('Shougo/deoplete.nvim')

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  " Visuals "
  call dein#add('morhetz/gruvbox')

  " Util "
  call dein#add('junegunn/fzf.vim')
  call dein#add('w0rp/ale')

  " Git "
  call dein#add('airblade/vim-gitgutter')

  " Language Server "
  call dein#add('autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' })

  " Latex "
  call dein#add('lervag/vimtex')

  " EchoDoc "
  call dein#add('Shougo/echodoc.vim')

  " TypeScript "
  call dein#add('HerringtonDarkholme/yats.vim', { 'on_ft': 'typescript' })

  call dein#end()
  call dein#save_state()
endif
