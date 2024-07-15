local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  -- Visuals
  'ellisonleao/gruvbox.nvim',

  'airblade/vim-gitgutter',

  'tpope/vim-fugitive',
  
  'neovim/nvim-lspconfig',

  {
    'nvim-treesitter/nvim-treesitter',
  },

  'nvim-treesitter/playground',

  'nvim-lua/lsp-status.nvim',

  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-ui-select.nvim',

  'dcampos/nvim-snippy',

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',

  'nvim-lua/plenary.nvim',
  'jose-elias-alvarez/null-ls.nvim',
  'MunifTanjim/prettier.nvim',

  'norcalli/nvim-colorizer.lua',

	{
	  'mrcjkb/rustaceanvim',
	  version = '^4', -- Recommended
	  lazy = false, -- This plugin is already lazy
	}
}
