nnoremap <C-p> :GFiles<CR>
nnoremap <C-F> :Ag<CR>

command -nargs=* CSOpen :!cs-open <args>
command CSCurrent :execute ':CSOpen '.expand('%').' L'.line('.').':'.col('.')

nnoremap <silent> gcs :CSCurrent<CR>
nnoremap <silent> gat /@Component<CR>/templateUrl<CR>:noh<CR>f'gf<ESC>
nnoremap <silent> gas /@Component<CR>/styleUrl<CR>:noh<CR>f'gf<ESC>

nnoremap <silent> gfn :!echo % \| xclip<CR>

nnoremap <silent> <leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <leader>_ :exe "resize " . (winheight(0) * 2/3)<CR>
