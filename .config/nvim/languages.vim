" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'typescript': [ 'javascript-typescript-stdio' ],
    \ 'typescript.tsx': [ 'javascript-typescript-stdio' ],
    \ 'javascript': [ 'javascript-typescript-stdio' ],
    \ 'rust': [ 'rls' ],
    \ 'lua': [ 'lua-lsp' ]
    \ }

function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <F5> :call LanguageClient_contextMenu()<CR>
    " Or map each action separately
    nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
  endif
endfunction

" EchoDoc "
set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

autocmd FileType * call LC_maps()
