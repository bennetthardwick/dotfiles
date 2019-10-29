nnoremap <C-p> :GFiles<CR>
nnoremap <C-F> :Ag<CR>

command -nargs=* CSOpen :!cs-open <args>
command CSCurrent :execute ':CSOpen '.expand('%').'\#L'.line('.').':'.col('.')

nnoremap <silent> <leader>cs :CSCurrent<CR>
nnoremap <silent> <leader>at /@Component<CR>/templateUrl<CR>:noh<CR>f'gf<ESC>
nnoremap <silent> <leader>as /@Component<CR>/styleUrl<CR>:noh<CR>f'gf<ESC>

" Yank the current word and search using Rg
nnoremap <silent> <leader>sw yiw:Rg <C-R>"<CR>

nnoremap <silent> gfn :!echo % \| xclip<CR>

nnoremap <silent> <leader>] :exe "vertical resize " . (winwidth(0) + 30)<CR>
nnoremap <silent> <leader>[ :exe "vertical resize " . (winwidth(0) - 30)<CR>

nnoremap <silent> <leader>= :exe "resize " . (winheight(0) + 10)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) - 10)<CR>

function! ToggleSpecFile()
  let l:file = expand('%')
  if empty(matchstr(l:file, '\.spec\.ts'))
    let l:spec_file = substitute(l:file, '\.ts$', '\.spec.ts', '')
    if filereadable(l:spec_file)
      execute 'e' l:spec_file
    else
      echo "No spec file found!"
    endif
  else
    let l:normal_file = substitute(l:file, '\.spec\.ts$', '\.ts', '')
    if filereadable(l:normal_file)
      execute 'e' l:normal_file
    else
      echo "No file found!"
    endif
  endif
endfunction

nnoremap <silent> <leader>sp :call ToggleSpecFile()<CR>


function! TestCurrentFile()
  if filereadable(@%)
    execute 'silent !echo % | xclip && i3-msg "scratchpad show, [instance=__scratchpad] move position center, [instance=__scratchpad] focus" && xdotool key Ctrl+c && xdotool type "run-jest --coverage=false" && xdotool key Return'
  else
    echo "File doesn't exist!"
  endif
endfunction

nnoremap <silent> <leader>tf :call TestCurrentFile()<CR>
nnoremap <silent> <leader>i :Format<CR>

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
