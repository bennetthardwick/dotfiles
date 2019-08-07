nnoremap <C-p> :GFiles<CR>
nnoremap <C-F> :Ag<CR>

command -nargs=* CSOpen :!cs-open <args>
command CSCurrent :execute ':CSOpen '.expand('%').'\#L'.line('.').':'.col('.')

nnoremap <silent> gcs :CSCurrent<CR>
nnoremap <silent> gat /@Component<CR>/templateUrl<CR>:noh<CR>f'gf<ESC>
nnoremap <silent> gas /@Component<CR>/styleUrl<CR>:noh<CR>f'gf<ESC>

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

nnoremap <silent> gsp :call ToggleSpecFile()<CR>


function! TestCurrentFile()
  if filereadable(@%)
    execute 'silent !echo % | xclip && i3-msg "scratchpad show, [instance=__scratchpad] move position center, [instance=__scratchpad] focus" && xdotool type "run-jest --coverage=false" && xdotool key Return'
  else
    echo "File doesn't exist!"
  endif
endfunction

nnoremap <silent> gtf :call TestCurrentFile()<CR>
