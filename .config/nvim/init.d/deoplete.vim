" --- Deoplete ---"

let g:deoplete#enable_at_startup = 1
let g:echodoc#enable_at_startup = 1

set splitbelow
set shortmess+=c

" -- Deoplete Preview Window "

function! Preview_func()
  if &pvw
    setlocal nonumber norelativenumber
  endif
endfunction

autocmd WinEnter * call Preview_func()
autocmd CompleteDone * pclose
