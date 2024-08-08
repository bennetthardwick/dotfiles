require('plugins')
require('colorizer').setup()
require('lsp')
require('custom')

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd [[
      augroup MarkdownSyntaxMatch
        autocmd FileType markdown syntax match @conceal /```/ conceal cchar=`
      augroup END
    ]]
  end,
})
