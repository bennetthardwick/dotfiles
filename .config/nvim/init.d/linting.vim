" -- ALE Linting -- "

let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ 'typescript': [ 'prettier', 'tslint' ],
      \ 'markdown': [],
      \ '*': [ 'remove_trailing_lines', 'trim_whitespace' ]
      \}
