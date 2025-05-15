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
	'tpope/vim-sleuth',

  'tpope/vim-fugitive',
  
  'neovim/nvim-lspconfig',

  'nvim-treesitter/nvim-treesitter',

  'nvim-treesitter/playground',

  'nvim-lua/lsp-status.nvim',

  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  'dcampos/nvim-snippy',

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',

  'nvim-lua/plenary.nvim',

  'norcalli/nvim-colorizer.lua',

	{
	  'mrcjkb/rustaceanvim',
	  version = '^6', -- Recommended
	  lazy = false, -- This plugin is already lazy
	},

	{
		'epwalsh/obsidian.nvim',
		version = '*',
		lazy = true,
		ft = "markdown",
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		opts = {
			workspaces = {
				{
					name = "notes",
					path = "~/notes/"
				}
			},
			completion = {
				nvim_cmp = true,
				min_chars = 1
			},

			new_notes_location = "notes_subdir",
			notes_subdir = "00 Inbox",

			daily_notes = {
				folder = "01 Daily/" .. os.date("%Y/%m %b/")
			}
		}
	},

	{
  	"olimorris/codecompanion.nvim",
  	config = true,
  	dependencies = {
  	  "nvim-lua/plenary.nvim",
  	  "nvim-treesitter/nvim-treesitter",
  	},
		opts = {
			adapters = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						schema = {
							model = {
								default = "qwen3:14b"
							}
						}
					})
				end
			},

  		strategies = {
  		  chat = {
  		    adapter = "ollama",
  		  },
  		  inline = {
  		    adapter = "ollama",
  		  },
  		  cmd = {
  		    adapter = "ollama",
  		  }
  		}
		}
	},

	{
	  "stevearc/conform.nvim",
	  event = { "BufReadPre", "BufNewFile" },
	  config = function()
	    local conform = require("conform")

	    conform.setup({
	      formatters_by_ft = {
	        javascript = { "prettier" },
	        typescript = { "prettier" },
	        javascriptreact = { "prettier" },
	        typescriptreact = { "prettier" },
	        svelte = { "prettier" },
	        css = { "prettier" },
	        html = { "prettier" },
	        json = { "prettier" },
	        yaml = { "prettier" },
	        markdown = { "prettier" },
	        graphql = { "prettier" },
	        lua = { "stylua" },
	        python = { "isort", "black" },
	      },
	    })
	  end,
	}
}
