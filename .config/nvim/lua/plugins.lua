return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Visuals
  use 'ellisonleao/gruvbox.nvim'

  use 'airblade/vim-gitgutter'

  use 'tpope/vim-fugitive'
  
  use 'neovim/nvim-lspconfig'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
  }

  use 'nvim-treesitter/playground'

  use 'nvim-lua/lsp-status.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
  }

  use 'dcampos/nvim-snippy'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'nvim-lua/plenary.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'

  use 'nvim-orgmode/orgmode'

  use {'akinsho/org-bullets.nvim', config = function()
    require('org-bullets').setup {
      symbols = {
        headlines = { "●", "●", "●", "●" }
      }
    }
  end}

  use 'norcalli/nvim-colorizer.lua'

  use 'norcalli/nvim-colorizer.lua'

  use 'epwalsh/obsidian.nvim'
end)
