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
 call dein#add('kana/vim-surround')
 call dein#add('scrooloose/nerdtree')
 call dein#add('junegunn/fzf.vim')
 call dein#add('w0rp/ale')

 " Git "
 call dein#add('airblade/vim-gitgutter')
 call dein#add('tpope/vim-fugitive')

 " JavaScript "
 call dein#add('zchee/deoplete-jedi', { 'on_ft': 'javascript' })

 " Latex "
 call dein#add('lervag/vimtex')

 " TypeScript "
 call dein#add('HerringtonDarkholme/yats.vim', { 'on_ft': 'typescript' })
 call dein#add('mhartington/nvim-typescript', { 'build': './install.sh', 'on_ft': 'typescript' })

 " C "
 call dein#add('zchee/deoplete-clang', { 'on_ft': [ 'c', 'cpp' ] })

 " Rust "
 call dein#add('sebastianmarkow/deoplete-rust', { 'on_ft': 'rust' })

 call dein#end()
 call dein#save_state()
endif
