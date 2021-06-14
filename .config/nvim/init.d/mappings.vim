nnoremap <C-p> :GFiles<CR>
nnoremap <C-F> :Ag<CR>

nnoremap <silent> <leader>cs :CSCurrent<CR>
nnoremap <silent> <leader>at /@Component<CR>/templateUrl<CR>:noh<CR>f'gf<ESC>
nnoremap <silent> <leader>as /@Component<CR>/styleUrl<CR>:noh<CR>f'gf<ESC>

" Yank the current word and search using Rg
nnoremap <silent> <leader>s yiw:Rg <C-R>"<CR>

" Copy the current file name to the clipboard
nnoremap <silent> gfn :!echo % \| xclip<CR>

" Use \[ and \] to vertically resize splits
nnoremap <silent> <leader>] :exe "vertical resize " . (winwidth(0) + 30)<CR>
nnoremap <silent> <leader>[ :exe "vertical resize " . (winwidth(0) - 30)<CR>

" Use \- and \= to horizontally resize splits
nnoremap <silent> <leader>= :exe "resize " . (winheight(0) + 10)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) - 10)<CR>

nnoremap <silent> <leader>i :Format<CR>

nnoremap <silent> <leader>e :Explore<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

nnoremap <silent> <leader>l :later 1f<CR>
nnoremap <silent> <leader>k :earlier 1f<CR>
