let g:deoplete#sources#rust#racer_binary='/usr/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/usr/share/rust-source/src'

autocmd Filetype rust map K :DeopleteRustShowDocumentation
autocmd Filetype rust map gd :DeopleteRustGoToDefinitionDefault
