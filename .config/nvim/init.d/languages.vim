lua << EOF

require'lspconfig'.tsserver.setup{
  on_attach = require'completion'.on_attach
}

EOF

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = [ 'exact', 'substring', 'fuzzy' ]


lua << EOF

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  }
}


EOF
