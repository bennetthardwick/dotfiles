return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Visuals
  use 'ellisonleao/gruvbox.nvim'

  -- " Util "
  -- Plug 'leafgarland/typescript-vim'
  -- Plug 'peitalin/vim-jsx-typescript'
  -- " Plug 'SirVer/ultisnips'
  -- Plug 'elixir-editors/vim-elixir'

  -- Plug 'junegunn/fzf.vim'
  
  use 'airblade/vim-gitgutter'

  -- Plug 'tpope/vim-sleuth'
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
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'dcampos/nvim-snippy'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use {'nvim-orgmode/orgmode', config = function() 
      local org = require('orgmode')

      org.setup {
        org_agenda_files = { '~/notes' },
        org_default_notes_file = '~/notes/refile.org',
        org_capture_templates = {
          t = { description = 'Task', template = '* TODO %?\n  %u' },
          j = { description = 'Journal', template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?', target = '~/notes/journal.org' }
        },
      } 

      org.setup_ts_grammar()
    end 
  }

end)